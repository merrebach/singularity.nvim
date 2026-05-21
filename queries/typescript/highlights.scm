; extends
; ============================================================================
; CUSTOM TYPESCRIPT TREESITTER HIGHLIGHT QUERIES — EXTENDED EDITION
; ============================================================================
; Datei: ~/.config/nvim/after/queries/typescript/highlights.scm
;
; Ziel: So viel semantische Information wie möglich aus der Syntax ableiten,
;       um dem LSP die Arbeit abzunehmen. Alle Captures sind hierarchisch
;       benannt und nutzen Neovims Fallback-System.
;
; Verifiziert gegen: tree-sitter-typescript grammar (define-grammar.js)
;       Node-Types: type_identifier, predefined_type, generic_type,
;       type_arguments, type_parameters, type_annotation, interface_declaration,
;       type_alias_declaration, enum_declaration, abstract_class_declaration,
;       mapped_type_clause, conditional_type, intersection_type, union_type,
;       template_literal_type, tuple_type, readonly_type, as_expression,
;       satisfies_expression, non_null_expression, required_parameter,
;       optional_parameter, public_field_definition, method_definition,
;       method_signature, abstract_method_signature, property_signature,
;       call_signature, construct_signature, index_signature,
;       accessibility_modifier, override_modifier, ambient_declaration,
;       function_signature, instantiation_expression, etc.
; ============================================================================


; ============================================================================
; 1. VARIABLE DECLARATIONS — const vs let vs var
; ============================================================================

; --- const Deklaration: immutable binding ---
(lexical_declaration
  "const" @keyword.declaration.const)

; --- let Deklaration: block-scoped mutable ---
(lexical_declaration
  "let" @keyword.declaration.let)

; --- var Deklaration: function-scoped ---
(variable_declaration
  "var" @keyword.declaration.var)

; --- using/await using Deklaration (TC39 Explicit Resource Management) ---
; HINWEIS: tree-sitter-typescript unterstützt "using" noch nicht als
; literal Token in lexical_declaration. Sobald die Grammar aktualisiert
; wird, kann dieser Block reaktiviert werden.
; (lexical_declaration
;   "using" @keyword.declaration.using)

; --- const Variablenname (direkt nach const) ---
(lexical_declaration
  "const"
  (variable_declarator
    name: (identifier) @variable.declaration.const))

; --- let Variablenname ---
(lexical_declaration
  "let"
  (variable_declarator
    name: (identifier) @variable.declaration.let))

; --- var Variablenname ---
(variable_declaration
  (variable_declarator
    name: (identifier) @variable.declaration.var))

; --- Definite Assignment: let x!: string ---
(variable_declarator
  name: (identifier) @variable.declaration.definite
  "!"
  type: (type_annotation))


; ============================================================================
; 2. TYPE SYSTEM — Vollständige Abdeckung aller Typ-Konstrukte
; ============================================================================

; --- Einfacher Type Identifier ---
(type_identifier) @type

; --- Built-in Types: any, string, number, boolean, void, never, unknown, object, symbol ---
(predefined_type) @type.builtin

; --- Generische Typen: Array<T>, Map<K, V>, Promise<R> ---
(generic_type
  name: (type_identifier) @type.generic)

(generic_type
  name: (nested_type_identifier
    module: (identifier) @type.module
    name: (type_identifier) @type.generic.nested))

; --- Generische Typ-Argumente: das <T, U> in Array<T> ---
(type_arguments
  (type_identifier) @type.argument)

; --- Generische Typ-Parameter-Deklaration: <T>, <T extends Base> ---
(type_parameter
  name: (type_identifier) @type.parameter)

; --- Default-Typ in Type-Parameter: <T = string> ---
(type_parameter
  value: (default_type
    (type_identifier) @type.parameter.default))

; --- Constraint: T extends SomeType ---
(constraint
  (type_identifier) @type.constraint)

; --- Nested Type Identifier: Namespace.SubType ---
(nested_type_identifier
  module: (identifier) @type.module
  name: (type_identifier) @type.nested)

; --- Union Types: A | B | C ---
(union_type
  (type_identifier) @type.union)

; --- Intersection Types: A & B ---
(intersection_type
  (type_identifier) @type.intersection)

; --- Tuple Types: [string, number, boolean] ---
(tuple_type
  (type_identifier) @type.tuple_element)

; --- Named Tuple Elements: [name: string, age: number] ---
(tuple_type
  (required_parameter
    (identifier) @variable.tuple_label))

(tuple_type
  (optional_parameter
    (identifier) @variable.tuple_label.optional))

; --- Rest Type in Tuple: [...T] ---
(rest_type
  (type_identifier) @type.rest)

; --- Optional Type in Tuple: string? ---
(optional_type
  (type_identifier) @type.optional)

; --- Mapped Types: { [K in keyof T]: V } ---
(mapped_type_clause
  name: (type_identifier) @type.mapped.key
  "in" @keyword.operator.in_type)

; --- Mapped Type mit as-Clause: { [K in keyof T as NewKey]: V } ---
(mapped_type_clause
  alias: (type_identifier) @type.mapped.alias)

; --- Conditional Types: T extends U ? X : Y ---
(conditional_type
  left: (type_identifier) @type.conditional.check
  right: (type_identifier) @type.conditional.extends
  consequence: (type_identifier) @type.conditional.true
  alternative: (type_identifier) @type.conditional.false)

; --- Index Access Types: T[K] ---
(lookup_type) @type.lookup

; --- Index Type Query: keyof T ---
(index_type_query
  "keyof" @keyword.operator.keyof
  (type_identifier) @type.keyof_target)

; --- Type Query: typeof expr ---
(type_query
  "typeof" @keyword.operator.typeof_type)

; --- Infer Type: infer T ---
(infer_type
  "infer" @keyword.operator.infer
  (type_identifier) @type.inferred)

; --- As Expression: expr as Type ---
(as_expression
  "as" @keyword.operator.as
  (type_identifier) @type.assertion.as)

; --- As Const: expr as const ---
(as_expression
  "as" @keyword.operator.as
  "const" @keyword.operator.as_const)

; --- Satisfies Expression: expr satisfies Type ---
(satisfies_expression
  "satisfies" @keyword.operator.satisfies
  (type_identifier) @type.satisfies)

; --- Readonly Type: readonly T ---
(readonly_type) @type.readonly

; --- Array Type: T[] ---
(array_type
  (type_identifier) @type.array_element)

; --- this Type ---
(this_type) @type.this

; --- Existential Type: * (Flow compat) ---
(existential_type) @type.existential

; --- Literal Types ---
(literal_type
  (string
    (string_fragment) @type.literal.string))

(literal_type
  (number) @type.literal.number)

(literal_type
  (true) @type.literal.boolean)

(literal_type
  (false) @type.literal.boolean)

(literal_type
  (null) @type.literal.null)

(literal_type
  (undefined) @type.literal.undefined)

; --- Negative Numeric Literal Type: -1 ---
(literal_type
  (unary_expression
    operator: "-" @type.literal.sign
    argument: (number) @type.literal.number))

; --- Template Literal Type: `prefix-${infer T}` ---
(template_literal_type) @type.template_literal

; --- Function Type: (a: string) => void ---
(function_type
  "=>" @punctuation.type.arrow)

; --- Constructor Type: new () => T ---
(constructor_type
  "new" @keyword.operator.new_type)

; --- Type Annotation Colon ---
(type_annotation
  ":" @punctuation.type.colon)

; --- Parenthesized Type ---
(parenthesized_type) @type.parenthesized

; --- Flow Maybe Type: ?Type ---
(flow_maybe_type) @type.maybe

; --- Bekannte Utility Types ---
(generic_type
  name: (type_identifier) @type.utility
  (#any-of? @type.utility
    "Partial" "Required" "Readonly" "Record"
    "Pick" "Omit" "Exclude" "Extract"
    "NonNullable" "ReturnType" "InstanceType"
    "Parameters" "ConstructorParameters"
    "ThisParameterType" "OmitThisParameter"
    "ThisType" "Awaited" "Uppercase" "Lowercase"
    "Capitalize" "Uncapitalize" "NoInfer"
    "Promise" "PromiseLike"
    "Array" "ReadonlyArray"
    "Map" "ReadonlyMap" "WeakMap"
    "Set" "ReadonlySet" "WeakSet" "WeakRef"
    "Iterable" "Iterator" "AsyncIterable" "AsyncIterator"
    "IterableIterator" "AsyncIterableIterator"
    "Generator" "AsyncGenerator"))


; ============================================================================
; 3. INTERFACE / TYPE ALIAS / ENUM — Deklarationsstrukturen
; ============================================================================

; --- Interface ---
(interface_declaration
  "interface" @keyword.declaration.interface
  name: (type_identifier) @type.interface.name)

; --- Interface Extends ---
(extends_type_clause
  "extends" @keyword.extends
  (type_identifier) @type.interface.extends)

(extends_type_clause
  (nested_type_identifier
    module: (identifier) @type.module.extends
    name: (type_identifier) @type.interface.extends.nested))

; --- Property Signature in Interface/Object Type ---
(property_signature
  name: (property_identifier) @property.signature)

; --- Optional Property Signature: name?: Type ---
(property_signature
  name: (property_identifier) @property.signature.optional
  "?")

; --- Readonly Property in Signature ---
(property_signature
  "readonly" @keyword.modifier.readonly
  name: (property_identifier) @property.signature.readonly)

; --- Method Signature in Interface ---
(method_signature
  name: (property_identifier) @function.method.signature)

; --- Optional Method Signature ---
(method_signature
  name: (property_identifier) @function.method.signature.optional
  "?")

; --- Call Signature: { (): ReturnType } ---
(call_signature) @function.call_signature

; --- Construct Signature: { new (): Type } ---
(construct_signature
  "new" @keyword.operator.new_construct)

; --- Index Signature: { [key: string]: Type } ---
(index_signature
  name: (identifier) @variable.index_signature
  type: (type_annotation) @type.index_signature)

; --- Type Alias ---
(type_alias_declaration
  "type" @keyword.declaration.type
  name: (type_identifier) @type.alias.name)

; --- Enum ---
(enum_declaration
  "enum" @keyword.declaration.enum
  name: (identifier) @type.enum.name)

; --- Const Enum ---
(enum_declaration
  "const" @keyword.modifier.const_enum
  "enum" @keyword.declaration.enum)

; --- Enum Members ---
(enum_assignment
  name: (property_identifier) @type.enum.member)

(enum_body
  (property_identifier) @type.enum.member)

; --- Enum Member mit String-Initialisierung ---
(enum_assignment
  name: (property_identifier) @type.enum.member.string
  (string))

; --- Enum Member mit numerischer Initialisierung ---
(enum_assignment
  name: (property_identifier) @type.enum.member.numeric
  (number))


; ============================================================================
; 4. KLASSEN — Vollständig
; ============================================================================

; --- Class Name ---
(class_declaration
  name: (type_identifier) @type.class.name)

; --- Abstract Class ---
(abstract_class_declaration
  "abstract" @keyword.modifier.abstract
  name: (type_identifier) @type.class.abstract)

; --- Extends Clause ---
(extends_clause
  "extends" @keyword.extends.class
  value: (identifier) @type.class.extends)

; --- Implements Clause ---
(implements_clause
  "implements" @keyword.implements
  (type_identifier) @type.class.implements)

; --- Type Parameters auf Klassen ---
(class_declaration
  type_parameters: (type_parameters
    (type_parameter
      name: (type_identifier) @type.class.type_parameter)))

; --- Constructor ---
(method_definition
  name: (property_identifier) @constructor
  (#eq? @constructor "constructor"))

; --- Constructor Parameter Property: constructor(public name: string) ---
(required_parameter
  (accessibility_modifier) @keyword.modifier.access.param
  (identifier) @property.constructor_param)

(required_parameter
  "readonly" @keyword.modifier.readonly.param
  (identifier) @property.constructor_param.readonly)

; --- Static Methods/Properties ---
(method_definition
  "static" @keyword.modifier.static)

(public_field_definition
  "static" @keyword.modifier.static)

; --- Override Modifier ---
(method_definition
  (override_modifier) @keyword.modifier.override)

; --- Abstract Method Signature ---
(abstract_method_signature
  "abstract" @keyword.modifier.abstract.method
  name: (property_identifier) @function.method.abstract)

; --- Abstract Method mit optionalem Marker ---
(abstract_method_signature
  name: (property_identifier) @function.method.abstract.optional
  "?")

; --- Access Modifiers ---
(accessibility_modifier) @keyword.modifier.access

; --- Getter/Setter ---
(method_definition
  "get" @keyword.accessor.get
  name: (property_identifier) @function.accessor.get)

(method_definition
  "set" @keyword.accessor.set
  name: (property_identifier) @function.accessor.set)

; --- Accessor Keyword (auto-accessor) ---
(public_field_definition
  "accessor" @keyword.modifier.accessor)

; --- Class Field ---
(public_field_definition
  name: (property_identifier) @property.class_field)

; --- Optional Class Field ---
(public_field_definition
  name: (property_identifier) @property.class_field.optional
  "?")

; --- Definite Class Field ---
(public_field_definition
  name: (property_identifier) @property.class_field.definite
  "!")

; --- Readonly Class Field ---
(public_field_definition
  "readonly" @keyword.modifier.readonly
  name: (property_identifier) @property.class_field.readonly)

; --- Declare on Class Field ---
(public_field_definition
  "declare" @keyword.modifier.declare)

; --- Class Static Block ---
(class_static_block
  "static" @keyword.modifier.static_block)

; --- Dekoratoren ---
(decorator
  "@" @punctuation.special.decorator)

(decorator
  (identifier) @attribute.decorator)

(decorator
  (call_expression
    function: (identifier) @attribute.decorator.call))

(decorator
  (member_expression
    object: (identifier) @attribute.decorator.module
    property: (property_identifier) @attribute.decorator.method))

(decorator
  (call_expression
    function: (member_expression
      object: (identifier) @attribute.decorator.module.call
      property: (property_identifier) @attribute.decorator.method.call)))


; ============================================================================
; 5. FUNKTIONEN — Parameter, Overloads, Signatures
; ============================================================================

; --- Funktionsname bei Deklaration ---
(function_declaration
  name: (identifier) @function.declaration)

; --- Arrow Function in Variable: const foo = () => {} ---
(lexical_declaration
  (variable_declarator
    name: (identifier) @function.variable.arrow
    value: (arrow_function)))

; --- Pflichtparameter ---
(required_parameter
  pattern: (identifier) @variable.parameter)

; --- Optionale Parameter: name? ---
(optional_parameter
  pattern: (identifier) @variable.parameter.optional
  "?" @punctuation.parameter.optional)

; --- Rest-Parameter: ...args ---
(required_parameter
  pattern: (rest_pattern
    (identifier) @variable.parameter.rest))

; --- Default-Parameter mit Wert ---
(required_parameter
  pattern: (identifier) @variable.parameter.default
  (identifier))

; --- Destructuring-Parameter ---
(required_parameter
  pattern: (object_pattern) @pattern.parameter.object)

(required_parameter
  pattern: (array_pattern) @pattern.parameter.array)

; --- this-Parameter: function foo(this: Type) ---
(required_parameter
  pattern: (this) @variable.parameter.this)

; --- Rückgabetyp-Annotation ---
(function_declaration
  return_type: (type_annotation
    (type_identifier) @type.return))

(arrow_function
  return_type: (type_annotation
    (type_identifier) @type.return))

(method_definition
  return_type: (type_annotation
    (type_identifier) @type.return))

; --- Rückgabetyp void explizit ---
(function_declaration
  return_type: (type_annotation
    (predefined_type) @type.return.builtin))

; --- Type Predicate als Rückgabetyp: x is Type ---
(type_predicate
  name: (identifier) @variable.type_predicate
  "is" @keyword.operator.is
  type: (type_identifier) @type.predicate)

; --- Assertion Annotation: asserts x is Type ---
(asserts_annotation
  (asserts
    "asserts" @keyword.operator.asserts))

; --- Function Signature (Overload/Ambient) ---
(function_signature
  "function" @keyword.declaration.function
  name: (identifier) @function.signature)

; --- Async ---
(function_declaration
  "async" @keyword.coroutine.async)

(arrow_function
  "async" @keyword.coroutine.async)

(method_definition
  "async" @keyword.coroutine.async)

; --- Generator ---
(generator_function_declaration
  name: (identifier) @function.generator)

; NOTE: "*" is not an exposed anonymous node in method_definition for generators
; (method_definition
;   "*" @punctuation.special.generator)

; --- IIFE Pattern: (function() {})() ---
(call_expression
  function: (parenthesized_expression
    (function_expression)) @function.iife)


; ============================================================================
; 6. OBJECT LITERALS — Keys, Shorthand, Methods, Computed
; ============================================================================

; --- Property Key: { key: value } ---
(pair
  key: (property_identifier) @property.object.key)

; --- String Key: { "key": value } ---
(pair
  key: (string
    (string_fragment) @property.object.key.string))

; --- Number Key: { 0: value } ---
(pair
  key: (number) @property.object.key.number)

; --- Computed Property: { [expr]: value } ---
(pair
  key: (computed_property_name) @property.object.key.computed)

; --- Shorthand Property: { name } (Identifier ist Key und Value) ---
(shorthand_property_identifier) @property.object.shorthand

; --- Method in Object Literal: { method() {} } ---
(method_definition
  name: (property_identifier) @function.method.object)

; --- Getter in Object Literal ---
(pair
  key: (property_identifier) @function.accessor.get.object
  value: (function_expression))

; --- Spread in Object: { ...obj } ---
(spread_element
  "..." @operator.spread)


; ============================================================================
; 7. DESTRUCTURING — Vollständig
; ============================================================================

; --- Object Destructuring Shorthand ---
(object_pattern
  (shorthand_property_identifier_pattern) @variable.destructured)

; --- Renamed: { a: renamed } ---
(object_pattern
  (pair_pattern
    key: (property_identifier) @property.destructured.key
    value: (identifier) @variable.destructured.value))

; --- Nested Destructuring: { a: { b } } ---
(object_pattern
  (pair_pattern
    key: (property_identifier) @property.destructured.key.nested
    value: (object_pattern)))

; --- Array Destructuring ---
(array_pattern
  (identifier) @variable.destructured.array)

; --- Rest in Object Destructuring ---
(object_pattern
  (rest_pattern
    (identifier) @variable.destructured.rest))

; --- Rest in Array Destructuring ---
(array_pattern
  (rest_pattern
    (identifier) @variable.destructured.rest.array))

; --- Default in Destructuring: { a = 5 } ---
(object_pattern
  (object_assignment_pattern
    left: (shorthand_property_identifier_pattern) @variable.destructured.default))

; --- Default in Array Destructuring: [a = 5] ---
(array_pattern
  (assignment_pattern
    left: (identifier) @variable.destructured.array.default))


; ============================================================================
; 8. TEMPLATE LITERALS — String Interpolation
; ============================================================================

(template_string) @string.template

(template_substitution
  "${" @punctuation.special.interpolation.open
  "}" @punctuation.special.interpolation.close)

(template_substitution
  (identifier) @variable.interpolation)

(template_substitution
  (member_expression
    object: (identifier) @variable.interpolation.object
    property: (property_identifier) @property.interpolation))

(template_substitution
  (call_expression
    function: (identifier) @function.interpolation))

; --- Tagged Template Literal: html`...`, css`...` ---
(call_expression
  function: (identifier) @function.tagged_template
  arguments: (template_string))


; ============================================================================
; 9. MEMBER EXPRESSIONS — Bekannte APIs differenzieren
; ============================================================================

; --- console.* ---
(call_expression
  function: (member_expression
    object: (identifier) @variable.builtin.console
    property: (property_identifier) @function.method.console)
  (#eq? @variable.builtin.console "console"))

; --- Console Log-Level differenzieren ---
(call_expression
  function: (member_expression
    object: (identifier) @_console
    property: (property_identifier) @function.method.console.log)
  (#eq? @_console "console")
  (#any-of? @function.method.console.log "log" "info" "debug"))

(call_expression
  function: (member_expression
    object: (identifier) @_console
    property: (property_identifier) @function.method.console.warn)
  (#eq? @_console "console")
  (#eq? @function.method.console.warn "warn"))

(call_expression
  function: (member_expression
    object: (identifier) @_console
    property: (property_identifier) @function.method.console.error)
  (#eq? @_console "console")
  (#any-of? @function.method.console.error "error" "trace"))

; --- Promise-Methoden ---
(call_expression
  function: (member_expression
    property: (property_identifier) @function.method.promise)
  (#any-of? @function.method.promise "then" "catch" "finally"))

; --- Promise Static Methods ---
(call_expression
  function: (member_expression
    object: (identifier) @variable.builtin.promise
    property: (property_identifier) @function.method.promise.static)
  (#eq? @variable.builtin.promise "Promise")
  (#any-of? @function.method.promise.static
    "all" "allSettled" "any" "race" "resolve" "reject" "withResolvers"))

; --- Array-Methoden (Iteration) ---
(call_expression
  function: (member_expression
    property: (property_identifier) @function.method.array.iterate)
  (#any-of? @function.method.array.iterate
    "map" "filter" "reduce" "reduceRight"
    "forEach" "find" "findIndex" "findLast" "findLastIndex"
    "some" "every" "flatMap" "flat"))

; --- Array-Methoden (Mutation) ---
(call_expression
  function: (member_expression
    property: (property_identifier) @function.method.array.mutate)
  (#any-of? @function.method.array.mutate
    "push" "pop" "shift" "unshift" "splice"
    "sort" "reverse" "fill" "copyWithin"))

; --- Array-Methoden (Accessor) ---
(call_expression
  function: (member_expression
    property: (property_identifier) @function.method.array.access)
  (#any-of? @function.method.array.access
    "slice" "concat" "join" "includes"
    "indexOf" "lastIndexOf" "at" "entries"
    "keys" "values" "with" "toReversed"
    "toSorted" "toSpliced"))

; --- Array Static Methods ---
(call_expression
  function: (member_expression
    object: (identifier) @variable.builtin.array
    property: (property_identifier) @function.method.array.static)
  (#eq? @variable.builtin.array "Array")
  (#any-of? @function.method.array.static
    "from" "of" "isArray" "fromAsync"))

; --- Object Static Methods ---
(call_expression
  function: (member_expression
    object: (identifier) @variable.builtin.object
    property: (property_identifier) @function.method.object.static)
  (#eq? @variable.builtin.object "Object")
  (#any-of? @function.method.object.static
    "keys" "values" "entries" "assign" "create"
    "defineProperty" "defineProperties"
    "freeze" "seal" "preventExtensions"
    "getOwnPropertyDescriptor" "getOwnPropertyDescriptors"
    "getOwnPropertyNames" "getOwnPropertySymbols"
    "getPrototypeOf" "setPrototypeOf"
    "is" "hasOwn" "fromEntries" "groupBy"))

; --- JSON Methods ---
(call_expression
  function: (member_expression
    object: (identifier) @variable.builtin.json
    property: (property_identifier) @function.method.json)
  (#eq? @variable.builtin.json "JSON")
  (#any-of? @function.method.json "parse" "stringify"))

; --- Math Methods ---
(call_expression
  function: (member_expression
    object: (identifier) @variable.builtin.math
    property: (property_identifier) @function.method.math)
  (#eq? @variable.builtin.math "Math"))

; --- String Methods ---
(call_expression
  function: (member_expression
    property: (property_identifier) @function.method.string)
  (#any-of? @function.method.string
    "charAt" "charCodeAt" "codePointAt"
    "startsWith" "endsWith" "includes"
    "indexOf" "lastIndexOf" "search"
    "match" "matchAll" "replace" "replaceAll"
    "slice" "substring" "trim" "trimStart" "trimEnd"
    "padStart" "padEnd" "repeat"
    "split" "toLowerCase" "toUpperCase" "toLocaleLowerCase" "toLocaleUpperCase"
    "normalize" "localeCompare" "at"))

; --- Number/parseInt/parseFloat ---
(call_expression
  function: (identifier) @function.builtin.global
  (#any-of? @function.builtin.global
    "parseInt" "parseFloat" "isNaN" "isFinite"
    "encodeURI" "decodeURI" "encodeURIComponent" "decodeURIComponent"
    "setTimeout" "clearTimeout" "setInterval" "clearInterval"
    "requestAnimationFrame" "cancelAnimationFrame"
    "queueMicrotask" "structuredClone"
    "atob" "btoa" "fetch"))

; --- Reflect / Proxy ---
(call_expression
  function: (member_expression
    object: (identifier) @variable.builtin.reflect)
  (#any-of? @variable.builtin.reflect "Reflect" "Proxy"))

; --- Symbol ---
(member_expression
  object: (identifier) @variable.builtin.symbol
  (#eq? @variable.builtin.symbol "Symbol"))

; --- globalThis / window / self / document ---
((identifier) @variable.builtin.global_object
  (#any-of? @variable.builtin.global_object
    "globalThis" "window" "self" "document" "navigator"))


; ============================================================================
; 10. IMPORTS / EXPORTS — Vollständig
; ============================================================================

; --- Import Statement ---
(import_statement
  "import" @keyword.import)

; --- Import Type: import type { X } ---
(import_statement
  "type" @keyword.import.type)

; --- From Clause ---
(import_statement
  source: (string
    (string_fragment) @string.import.source))

; --- Named Import: { name } ---
(import_specifier
  name: (identifier) @variable.import)

; --- Renamed Import: { name as alias } ---
(import_specifier
  name: (identifier) @variable.import.original
  alias: (identifier) @variable.import.alias)

; --- Type-only Import Specifier ---
(import_specifier
  "type" @keyword.import.type.specifier)

; --- Default Import ---
(import_clause
  (identifier) @variable.import.default)

; --- Namespace Import: import * as ns ---
(namespace_import
  "*" @keyword.import.wildcard
  (identifier) @module.import.namespace)

; --- Dynamic Import: import("module") ---
(call_expression
  function: (import) @keyword.import.dynamic)

; --- Import Require: import x = require("module") ---
(import_require_clause
  (identifier) @variable.import.require
  "require" @function.builtin.require)

; --- Import Alias: import A = B.C ---
(import_alias
  "import" @keyword.import.alias
  (identifier) @variable.import.alias.name)

; --- Import Assertion/Attribute: with { type: "json" } ---
(import_attribute) @keyword.import.attribute

; --- Export Statement ---
(export_statement
  "export" @keyword.export)

; --- Export Default ---
(export_statement
  "default" @keyword.export.default)

; --- Export Type ---
(export_statement
  "type" @keyword.export.type)

; --- Named Export ---
(export_specifier
  name: (identifier) @variable.export)

; --- Renamed Export ---
(export_specifier
  alias: (identifier) @variable.export.alias)

; --- Re-Export: export { x } from "module" ---
(export_statement
  source: (string
    (string_fragment) @string.export.source))

; --- Export as namespace: export as namespace X ---
(export_statement
  "as" @keyword.export.as
  "namespace" @keyword.export.namespace)


; ============================================================================
; 11. AMBIENT / DECLARE — Deklarationen ohne Implementation
; ============================================================================

; --- Ambient Declaration ---
(ambient_declaration
  "declare" @keyword.declaration.declare)

; --- Declare Global ---
(ambient_declaration
  "global" @keyword.declaration.global)

; --- Declare Module ---
(ambient_declaration
  "module" @keyword.declaration.module)


; ============================================================================
; 12. OPERATOREN — Spezifisch
; ============================================================================

; --- Non-Null Assertion: expr! ---
(non_null_expression
  "!" @operator.non_null)

; --- Optional Chaining: ?. ---
(optional_chain) @operator.optional_chain

; --- Nullish Coalescing: ?? ---
"??" @operator.nullish_coalescing

; --- Nullish Assignment: ??= ---
"??=" @operator.nullish_assignment

; --- Logical OR Assignment: ||= ---
"||=" @operator.logical_or_assignment

; --- Logical AND Assignment: &&= ---
"&&=" @operator.logical_and_assignment

; --- Typeof in Expression ---
(unary_expression
  operator: "typeof" @keyword.operator.typeof)

; --- Void Operator ---
(unary_expression
  operator: "void" @keyword.operator.void)

; --- Delete Operator ---
(unary_expression
  operator: "delete" @keyword.operator.delete)

; --- In Operator ---
(binary_expression
  operator: "in" @keyword.operator.in)

; --- Instanceof ---
(binary_expression
  operator: "instanceof" @keyword.operator.instanceof)

; --- New Expression ---
(new_expression
  "new" @keyword.operator.new
  constructor: (identifier) @type.constructor)

; --- New mit Member Expression: new Module.Class() ---
(new_expression
  "new" @keyword.operator.new
  constructor: (member_expression
    object: (identifier) @type.constructor.module
    property: (property_identifier) @type.constructor.name))

; --- Ternary/Conditional ---
(ternary_expression
  "?" @operator.ternary.question
  ":" @operator.ternary.colon)

; --- Comma Operator ---
(sequence_expression
  "," @operator.comma)

; --- Instantiation Expression: func<T> (no call) ---
(instantiation_expression) @expression.instantiation


; ============================================================================
; 13. CONTROL FLOW — Spezifische Keywords
; ============================================================================

; --- Await ---
(await_expression
  "await" @keyword.coroutine.await)

; --- Yield / Yield* ---
(yield_expression
  "yield" @keyword.coroutine.yield)

; --- Throw ---
(throw_statement
  "throw" @keyword.exception.throw)

; --- Try / Catch / Finally ---
(try_statement
  "try" @keyword.exception.try)

(catch_clause
  "catch" @keyword.exception.catch
  parameter: (identifier) @variable.exception)

; --- Typed Catch: catch (e: unknown) ---
(catch_clause
  parameter: (identifier) @variable.exception.typed
  type: (type_annotation))

(finally_clause
  "finally" @keyword.exception.finally)

; --- For-In ---
(for_in_statement
  "for" @keyword.loop.for
  "in" @keyword.loop.in)

; --- For-Of ---
(for_in_statement
  "for" @keyword.loop.for
  "of" @keyword.loop.of)

; --- For-Await-Of ---
(for_in_statement
  "await" @keyword.loop.await)

; --- Switch Discriminant ---
(switch_statement
  value: (parenthesized_expression) @expression.switch.discriminant)

; --- Case Value ---
(switch_case
  "case" @keyword.switch.case
  value: (identifier) @variable.switch.case)

; --- Default Case ---
(switch_default
  "default" @keyword.switch.default)

; --- Labeled Statement ---
(labeled_statement
  label: (statement_identifier) @label)

; --- Break/Continue with Label ---
(break_statement
  "break" @keyword.control.break
  (statement_identifier) @label.target)

(continue_statement
  "continue" @keyword.control.continue
  (statement_identifier) @label.target)

; --- Return ---
(return_statement
  "return" @keyword.control.return)


; ============================================================================
; 14. NUMERIC LITERALS — Differenziert
; ============================================================================

; --- Dezimal ---
(number) @number

; --- Hex ---
((number) @number.hex
  (#lua-match? @number.hex "^0[xX]"))

; --- Binary ---
((number) @number.binary
  (#lua-match? @number.binary "^0[bB]"))

; --- Octal ---
((number) @number.octal
  (#lua-match? @number.octal "^0[oO]"))

; --- BigInt ---
((number) @number.bigint
  (#lua-match? @number.bigint "n$"))


; ============================================================================
; 15. STRINGS — Differenziert
; ============================================================================

; --- String Escape Sequences ---
(escape_sequence) @string.escape

; --- Regex ---
(regex) @string.regex
(regex_pattern) @string.regex.pattern
(regex_flags) @string.regex.flags


; ============================================================================
; 16. COMMENTS — JSDoc und regulär
; ============================================================================

; --- Single-line Comment ---
((comment) @comment.line
  (#lua-match? @comment.line "^//"))

; --- Multi-line Comment ---
((comment) @comment.block
  (#lua-match? @comment.block "^/%*[^%*]"))

; --- JSDoc Comment ---
((comment) @comment.documentation
  (#lua-match? @comment.documentation "^/%*%*"))

; --- TODO/FIXME/HACK/NOTE in Kommentaren ---
((comment) @comment.todo
  (#any-of? @comment.todo
    "TODO" "FIXME" "HACK" "NOTE" "BUG" "XXX" "WARN" "PERF"))


; ============================================================================
; 17. SPEZIELLE IDENTIFIER UND KONVENTIONEN
; ============================================================================

; --- SCREAMING_SNAKE_CASE → Konstante ---
((identifier) @constant.convention
  (#lua-match? @constant.convention "^[A-Z][A-Z0-9_]+$"))

; --- PascalCase Identifier (wahrscheinlich Typ/Klasse) ---
; In Ausdrucks-Positionen (nicht Type) — hilft bei new MyClass()
((identifier) @type.convention.pascal
  (#lua-match? @type.convention.pascal "^[A-Z][a-z]"))

; --- Boolean Literale ---
(true) @boolean.true
(false) @boolean.false

; --- null ---
(null) @constant.builtin.null

; --- undefined ---
((identifier) @constant.builtin.undefined
  (#eq? @constant.builtin.undefined "undefined"))

; --- NaN / Infinity ---
((identifier) @constant.builtin.numeric
  (#any-of? @constant.builtin.numeric "NaN" "Infinity"))

; --- this ---
(this) @variable.builtin.this

; --- super ---
(super) @variable.builtin.super

; --- arguments ---
((identifier) @variable.builtin.arguments
  (#eq? @variable.builtin.arguments "arguments"))

; --- Module/Namespace Name ---
(module
  name: (identifier) @module.name)

(module
  name: (string
    (string_fragment) @module.name.string))

(internal_module
  name: (identifier) @module.namespace)

; --- Labeled Tuple Elements ---
(required_parameter
  pattern: (identifier) @variable.tuple_label)

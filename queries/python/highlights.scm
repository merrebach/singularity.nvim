; extends
; ============================================================================
; CUSTOM PYTHON TREESITTER HIGHLIGHT QUERIES — EXTENDED EDITION
; ============================================================================
; Datei: ~/.config/nvim/after/queries/python/highlights.scm
;
; Ziel: So viel semantische Information wie möglich aus der Syntax ableiten,
;       um dem LSP die Arbeit abzunehmen. Alle Captures sind hierarchisch
;       benannt und nutzen Neovims Fallback-System.
;
; Verifiziert gegen: tree-sitter-python grammar (grammar.js)
;       Node-Types: function_definition, class_definition, decorator,
;       decorated_definition, parameters, typed_parameter,
;       typed_default_parameter, list_comprehension,
;       dictionary_comprehension, set_comprehension, generator_expression,
;       lambda, conditional_expression, for_in_clause, if_clause,
;       assignment, augmented_assignment, pattern_list, match_statement,
;       case_clause, case_pattern, interpolation, format_specifier,
;       global_statement, nonlocal_statement, type_alias_statement, etc.
; ============================================================================


; ============================================================================
; 1. SELF / CLS — Zentrale Python-Konvention
; ============================================================================

; --- self als erster Parameter ---
(function_definition
  parameters: (parameters
    . (identifier) @variable.builtin.self)
  (#eq? @variable.builtin.self "self"))

; --- cls als erster Parameter ---
(function_definition
  parameters: (parameters
    . (identifier) @variable.builtin.cls)
  (#eq? @variable.builtin.cls "cls"))

; --- self als typisierter erster Parameter ---
(function_definition
  parameters: (parameters
    . (typed_parameter
        (identifier) @variable.builtin.self))
  (#eq? @variable.builtin.self "self"))

; --- cls als typisierter erster Parameter ---
(function_definition
  parameters: (parameters
    . (typed_parameter
        (identifier) @variable.builtin.cls))
  (#eq? @variable.builtin.cls "cls"))

; --- self.attribute Access ---
(attribute
  object: (identifier) @variable.builtin.self
  attribute: (identifier) @property.instance
  (#eq? @variable.builtin.self "self"))

; --- cls.attribute Access ---
(attribute
  object: (identifier) @variable.builtin.cls
  attribute: (identifier) @property.class_attr
  (#eq? @variable.builtin.cls "cls"))

; --- self in Methoden-Aufruf: self.method() ---
(call
  function: (attribute
    object: (identifier) @variable.builtin.self
    attribute: (identifier) @function.method.self)
  (#eq? @variable.builtin.self "self"))

; --- cls in Methoden-Aufruf: cls.method() ---
(call
  function: (attribute
    object: (identifier) @variable.builtin.cls
    attribute: (identifier) @function.method.cls)
  (#eq? @variable.builtin.cls "cls"))


; ============================================================================
; 2. DEKORATOREN — Vollständig differenziert
; ============================================================================

; --- Dekorator @ Zeichen ---
(decorator
  "@" @punctuation.special.decorator)

; --- Einfacher Dekorator: @name ---
(decorator
  (identifier) @attribute.decorator)

; --- Dekorator mit Aufruf: @name(args) ---
(decorator
  (call
    function: (identifier) @attribute.decorator.call))

; --- Dekorator mit Punkt: @module.name ---
(decorator
  (attribute
    object: (identifier) @attribute.decorator.module
    attribute: (identifier) @attribute.decorator.method))

; --- Dekorator mit Punkt + Aufruf: @module.name(args) ---
(decorator
  (call
    function: (attribute
      object: (identifier) @attribute.decorator.module.call
      attribute: (identifier) @attribute.decorator.method.call)))

; --- Chained Dekorator: @module.sub.name ---
(decorator
  (attribute
    object: (attribute
      object: (identifier) @attribute.decorator.module.deep
      attribute: (identifier) @attribute.decorator.submodule)
    attribute: (identifier) @attribute.decorator.method.deep))

; --- Built-in Dekoratoren ---
(decorator
  (identifier) @attribute.decorator.builtin
  (#any-of? @attribute.decorator.builtin
    "staticmethod" "classmethod" "property"
    "abstractmethod" "overload" "override"
    "final"))

; --- Caching-Dekoratoren ---
(decorator
  (identifier) @attribute.decorator.caching
  (#any-of? @attribute.decorator.caching
    "cache" "cached_property" "lru_cache"))

(decorator
  (call
    function: (identifier) @attribute.decorator.caching.call
    (#any-of? @attribute.decorator.caching.call
      "cache" "cached_property" "lru_cache")))

; --- Dataclass-Dekoratoren ---
(decorator
  (identifier) @attribute.decorator.dataclass
  (#eq? @attribute.decorator.dataclass "dataclass"))

(decorator
  (call
    function: (identifier) @attribute.decorator.dataclass.call
    (#eq? @attribute.decorator.dataclass.call "dataclass")))

; --- functools Dekoratoren ---
(decorator
  (call
    function: (identifier) @attribute.decorator.functools
    (#any-of? @attribute.decorator.functools
      "wraps" "total_ordering" "singledispatch"
      "singledispatchmethod")))


; ============================================================================
; 3. TYPE HINTS — Vollständige Abdeckung
; ============================================================================

; --- Parameter Type Annotation: def foo(x: int) ---
(typed_parameter
  type: (type) @type.annotation.parameter)

; --- Parameter mit Default + Typ: def foo(x: int = 5) ---
(typed_default_parameter
  type: (type) @type.annotation.parameter.default)

; --- Rückgabetyp: def foo() -> ReturnType ---
(function_definition
  return_type: (type) @type.annotation.return)

; --- Variable Annotation: x: int = 5 ---
(assignment
  type: (type) @type.annotation.variable)

; --- Standalone Annotation: x: int (ohne Assignment) ---
(type
  (identifier) @type.annotation)

; --- Subscript in Type: List[int], Dict[str, Any] ---
(type
  (subscript
    value: (identifier) @type.generic
    subscript: (identifier) @type.argument))

; --- Nested Subscript: Dict[str, List[int]] ---
(type
  (subscript
    value: (identifier) @type.generic
    subscript: (subscript
      value: (identifier) @type.argument.generic)))

; --- Tuple Type Subscript: tuple[int, str, ...] ---
(type
  (subscript
    value: (identifier) @type.generic.tuple
    (#eq? @type.generic.tuple "tuple")))

; --- Callable Type: Callable[[int, str], bool] ---
(type
  (subscript
    value: (identifier) @type.generic.callable
    (#eq? @type.generic.callable "Callable")))

; --- Built-in Typen in Type-Positionen ---
(type
  (identifier) @type.builtin.python
  (#any-of? @type.builtin.python
    "int" "float" "str" "bytes" "bool"
    "list" "dict" "tuple" "set" "frozenset"
    "type" "object" "complex" "range"
    "bytearray" "memoryview" "slice"))

; --- None als Typ ---
(type
  (none) @type.none)

; --- Typing-Module Typen ---
(type
  (identifier) @type.typing
  (#any-of? @type.typing
    "Optional" "Union" "List" "Dict" "Tuple" "Set" "FrozenSet"
    "Sequence" "Mapping" "MutableMapping" "MutableSequence"
    "Iterable" "Iterator" "Generator" "Coroutine"
    "AsyncGenerator" "AsyncIterator" "AsyncIterable"
    "Callable" "Awaitable" "ClassVar" "Final" "Literal"
    "TypeVar" "TypeAlias" "TypeGuard" "TypeIs"
    "ParamSpec" "Concatenate"
    "Protocol" "Generic" "Any" "NoReturn" "Never" "Self"
    "Unpack" "TypeVarTuple" "NamedTuple" "TypedDict"
    "Annotated" "Required" "NotRequired"
    "SupportsInt" "SupportsFloat" "SupportsComplex"
    "SupportsBytes" "SupportsAbs" "SupportsRound"
    "IO" "TextIO" "BinaryIO"
    "Pattern" "Match"
    "OrderedDict" "Counter" "ChainMap" "DefaultDict" "Deque"))

; --- Pipe Union Syntax (3.10+): int | str ---
(type
  (binary_operator
    operator: "|" @type.union.operator))

; --- Star Unpack in Type: *tuple[int, ...] ---
; NOTE: unary_operator with "*" is not valid inside (type) in tree-sitter-python v0.25.0
; The grammar uses splat_type or similar; commented until grammar supports it.
; (type
;   (unary_operator
;     operator: "*" @type.unpack))

; --- Type Alias (3.12+): type Point = tuple[int, int] ---
(type_alias_statement
  "type" @keyword.declaration.type
  left: (type) @type.alias.name)

; --- TypeVar Declarations ---
(assignment
  left: (identifier) @type.typevar
  right: (call
    function: (identifier) @_typevar_func
    (#eq? @_typevar_func "TypeVar")))


; ============================================================================
; 4. DUNDER METHODS — Vollständig kategorisiert
; ============================================================================

; --- Catch-All für alle Dunder Methods ---
(function_definition
  name: (identifier) @function.dunder
  (#lua-match? @function.dunder "^__.*__$"))

; --- Lifecycle ---
(function_definition
  name: (identifier) @function.dunder.lifecycle
  (#any-of? @function.dunder.lifecycle
    "__init__" "__new__" "__del__"
    "__post_init__" "__init_subclass__" "__set_name__"
    "__class_getitem__"))

; --- Repräsentation ---
(function_definition
  name: (identifier) @function.dunder.representation
  (#any-of? @function.dunder.representation
    "__str__" "__repr__" "__format__"
    "__bytes__" "__hash__" "__bool__"
    "__sizeof__" "__length_hint__"))

; --- Comparison Operators ---
(function_definition
  name: (identifier) @function.dunder.comparison
  (#any-of? @function.dunder.comparison
    "__eq__" "__ne__" "__lt__" "__le__" "__gt__" "__ge__"))

; --- Arithmetic Operators ---
(function_definition
  name: (identifier) @function.dunder.arithmetic
  (#any-of? @function.dunder.arithmetic
    "__add__" "__sub__" "__mul__" "__truediv__" "__floordiv__"
    "__mod__" "__pow__" "__matmul__" "__divmod__"
    "__radd__" "__rsub__" "__rmul__" "__rtruediv__" "__rfloordiv__"
    "__rmod__" "__rpow__" "__rmatmul__"
    "__iadd__" "__isub__" "__imul__" "__itruediv__" "__ifloordiv__"
    "__imod__" "__ipow__" "__imatmul__"
    "__neg__" "__pos__" "__abs__" "__invert__"
    "__round__" "__trunc__" "__floor__" "__ceil__"))

; --- Bitwise Operators ---
(function_definition
  name: (identifier) @function.dunder.bitwise
  (#any-of? @function.dunder.bitwise
    "__and__" "__or__" "__xor__" "__lshift__" "__rshift__"
    "__rand__" "__ror__" "__rxor__" "__rlshift__" "__rrshift__"
    "__iand__" "__ior__" "__ixor__" "__ilshift__" "__irshift__"))

; --- Container Protocol ---
(function_definition
  name: (identifier) @function.dunder.container
  (#any-of? @function.dunder.container
    "__len__" "__contains__"
    "__getitem__" "__setitem__" "__delitem__"
    "__iter__" "__next__" "__reversed__"
    "__missing__"))

; --- Callable ---
(function_definition
  name: (identifier) @function.dunder.callable
  (#eq? @function.dunder.callable "__call__"))

; --- Context Manager ---
(function_definition
  name: (identifier) @function.dunder.context
  (#any-of? @function.dunder.context
    "__enter__" "__exit__"
    "__aenter__" "__aexit__"))

; --- Async Protocol ---
(function_definition
  name: (identifier) @function.dunder.async
  (#any-of? @function.dunder.async
    "__await__" "__aiter__" "__anext__"))

; --- Descriptor Protocol ---
(function_definition
  name: (identifier) @function.dunder.descriptor
  (#any-of? @function.dunder.descriptor
    "__get__" "__set__" "__delete__"
    "__getattr__" "__setattr__" "__delattr__"
    "__getattribute__"))

; --- Conversion ---
(function_definition
  name: (identifier) @function.dunder.conversion
  (#any-of? @function.dunder.conversion
    "__int__" "__float__" "__complex__"
    "__index__" "__bool__"))

; --- Copy ---
(function_definition
  name: (identifier) @function.dunder.copy
  (#any-of? @function.dunder.copy
    "__copy__" "__deepcopy__" "__reduce__" "__reduce_ex__"
    "__getstate__" "__setstate__"))


; ============================================================================
; 5. F-STRINGS — Vollständig
; ============================================================================

; --- f-String Erkennung über Prefix ---
(string
  (string_start) @string.fstring.start
  (#lua-match? @string.fstring.start "^[fF]"))

; --- Interpolation Klammern ---
(interpolation
  "{" @punctuation.special.interpolation.open
  "}" @punctuation.special.interpolation.close)

; --- Identifier in Interpolation ---
(interpolation
  (identifier) @variable.interpolation)

; --- Attributzugriff in Interpolation ---
(interpolation
  (attribute
    object: (identifier) @variable.interpolation.object
    attribute: (identifier) @property.interpolation))

; --- Methoden-Aufruf in Interpolation ---
(interpolation
  (call
    function: (identifier) @function.interpolation))

(interpolation
  (call
    function: (attribute
      attribute: (identifier) @function.method.interpolation)))

; --- Subscript in Interpolation: {dict["key"]} ---
(interpolation
  (subscript
    value: (identifier) @variable.interpolation.subscript))

; --- Format Spec ---
(interpolation
  (format_specifier) @string.fstring.format_spec)

; --- Conversion Flag: !r, !s, !a ---
(interpolation
  (type_conversion) @punctuation.special.conversion)


; ============================================================================
; 6. STRING-TYPEN — Prefixe differenzieren
; ============================================================================

; --- Raw String ---
(string
  (string_start) @string.raw.start
  (#lua-match? @string.raw.start "^[rR]\""))

(string
  (string_start) @string.raw.start
  (#lua-match? @string.raw.start "^[rR]'"))

; --- Byte String ---
(string
  (string_start) @string.bytes.start
  (#lua-match? @string.bytes.start "^[bB]"))

; --- Raw Byte String ---
(string
  (string_start) @string.raw_bytes.start
  (#lua-match? @string.raw_bytes.start "^[rRbB][rRbB]"))

; --- Escape Sequences ---
(escape_sequence) @string.escape

; --- Docstring: Erster Ausdruck in Funktion/Klasse/Modul ---
(function_definition
  body: (block
    . (expression_statement
        (string) @string.docstring)))

(class_definition
  body: (block
    . (expression_statement
        (string) @string.docstring)))

; --- Modul-Level Docstring ---
(module
  . (expression_statement
      (string) @string.docstring.module))


; ============================================================================
; 7. COMPREHENSIONS — Alle Varianten
; ============================================================================

; --- List Comprehension ---
(list_comprehension
  body: (_) @expression.comprehension.body)

; --- Dict Comprehension ---
(dictionary_comprehension
  body: (pair
    key: (_) @expression.comprehension.dict.key
    value: (_) @expression.comprehension.dict.value))

; --- for_in_clause in Comprehensions ---
(for_in_clause
  "for" @keyword.comprehension.for
  left: (identifier) @variable.comprehension.target
  "in" @keyword.comprehension.in)

; --- Tuple Unpacking in Comprehension: for k, v in ... ---
(for_in_clause
  left: (pattern_list
    (identifier) @variable.comprehension.target.unpack))

; --- If Filter in Comprehension ---
(if_clause
  "if" @keyword.comprehension.filter)

; --- Nested for_in_clause ---
; NOTE: for_in_clause cannot be nested inside another for_in_clause in the grammar.
; Multiple for clauses are siblings in the comprehension body, not parent-child.
; (for_in_clause
;   (for_in_clause
;     "for" @keyword.comprehension.for.nested
;     "in" @keyword.comprehension.in.nested))


; ============================================================================
; 8. KLASSEN — Vollständig
; ============================================================================

; --- Klassen-Name ---
(class_definition
  name: (identifier) @type.class.name)

; --- Basisklasse ---
(class_definition
  superclasses: (argument_list
    (identifier) @type.class.parent))

; --- Bekannte Basisklassen ---
(class_definition
  superclasses: (argument_list
    (identifier) @type.class.parent.builtin
    (#any-of? @type.class.parent.builtin
      "ABC" "Protocol" "Generic" "TypedDict" "NamedTuple"
      "Enum" "IntEnum" "StrEnum" "Flag" "IntFlag"
      "Exception" "BaseException" "ValueError" "TypeError"
      "RuntimeError" "KeyError" "AttributeError"
      "IndexError" "StopIteration" "StopAsyncIteration"
      "OSError" "IOError" "FileNotFoundError"
      "PermissionError" "NotImplementedError"
      "BaseModel" "Field")))

; --- Generische Basisklasse: class Foo(Generic[T]) ---
(class_definition
  superclasses: (argument_list
    (subscript
      value: (identifier) @type.class.parent.generic
      (#eq? @type.class.parent.generic "Generic"))))

; --- Metaclass Keyword ---
(class_definition
  superclasses: (argument_list
    (keyword_argument
      name: (identifier) @keyword.class.metaclass
      (#eq? @keyword.class.metaclass "metaclass")
      value: (identifier) @type.class.metaclass)))

; --- Class Body Assignment = Class Variable ---
(class_definition
  body: (block
    (expression_statement
      (assignment
        left: (identifier) @property.class_variable))))

; --- Typed Class Variable: name: str = "default" ---
(class_definition
  body: (block
    (expression_statement
      (assignment
        left: (identifier) @property.class_variable.typed
        type: (type)))))

; --- __slots__ ---
(expression_statement
  (assignment
    left: (identifier) @variable.special.slots
    (#eq? @variable.special.slots "__slots__")))

; --- __all__ ---
(expression_statement
  (assignment
    left: (identifier) @variable.special.all
    (#eq? @variable.special.all "__all__")))

; --- __version__ ---
(expression_statement
  (assignment
    left: (identifier) @variable.special.version
    (#eq? @variable.special.version "__version__")))


; ============================================================================
; 9. FUNKTIONEN UND PARAMETER — Vollständig
; ============================================================================

; --- Funktionsname ---
(function_definition
  name: (identifier) @function.definition)

; --- Async Function ---
(function_definition
  "async" @keyword.coroutine.async
  name: (identifier) @function.definition.async)

; --- Positional-Only Separator: / ---
(parameters
  (positional_separator) @punctuation.parameter.positional_only)

; --- Keyword-Only Separator: * ---
(parameters
  (keyword_separator) @punctuation.parameter.keyword_only)

; --- Default Parameter: def foo(x=5) ---
(default_parameter
  name: (identifier) @variable.parameter.default)

; --- Typed Default Parameter ---
(typed_default_parameter
  name: (identifier) @variable.parameter.typed_default)

; --- Typed Parameter ---
(typed_parameter
  (identifier) @variable.parameter.typed)

; --- Regular Parameter ---
(parameters
  (identifier) @variable.parameter)

; --- *args ---
(parameters
  (list_splat_pattern
    (identifier) @variable.parameter.args))

; --- **kwargs ---
(parameters
  (dictionary_splat_pattern
    (identifier) @variable.parameter.kwargs))

; --- Lambda ---
(lambda
  "lambda" @keyword.lambda)

(lambda_parameters
  (identifier) @variable.parameter.lambda)

; --- Lambda Default ---
(lambda_parameters
  (default_parameter
    name: (identifier) @variable.parameter.lambda.default))


; ============================================================================
; 10. BUILT-IN FUNKTIONSAUFRUFE — Vollständig
; ============================================================================

; --- Built-in Functions ---
(call
  function: (identifier) @function.builtin.python
  (#any-of? @function.builtin.python
    "print" "len" "range" "enumerate" "zip"
    "map" "filter" "sorted" "reversed"
    "isinstance" "issubclass" "hasattr" "getattr" "setattr" "delattr"
    "type" "id" "hash" "repr" "str" "int" "float" "bool"
    "list" "dict" "set" "tuple" "frozenset"
    "super" "property" "staticmethod" "classmethod"
    "abs" "min" "max" "sum" "round" "pow" "divmod"
    "open" "input" "iter" "next"
    "vars" "dir" "help" "callable"
    "any" "all" "chr" "ord" "hex" "oct" "bin"
    "format" "ascii" "breakpoint"
    "compile" "eval" "exec"
    "globals" "locals" "memoryview" "object"
    "__import__" "bytes" "bytearray"
    "complex" "slice" "frozenset"
    "getattr" "setattr" "delattr"
    "issubclass" "isinstance"))

; --- super() speziell ---
(call
  function: (identifier) @function.builtin.super
  (#eq? @function.builtin.super "super"))

; --- Typ-Konstruktoren ---
(call
  function: (identifier) @function.builtin.constructor
  (#any-of? @function.builtin.constructor
    "int" "float" "str" "bool" "bytes"
    "list" "dict" "set" "tuple" "frozenset"
    "complex" "bytearray" "memoryview"
    "range" "slice" "object" "type"))

; --- Assertion-Methoden (pytest/unittest) ---
(call
  function: (attribute
    attribute: (identifier) @function.method.assert)
  (#lua-match? @function.method.assert "^assert"))

; --- Klassen-Instanziierung (PascalCase Call) ---
(call
  function: (identifier) @type.constructor.call
  (#lua-match? @type.constructor.call "^[A-Z]"))

; --- Logging Methoden ---
(call
  function: (attribute
    object: (identifier) @_logger
    attribute: (identifier) @function.method.logging.debug)
  (#any-of? @_logger "logger" "log" "logging" "LOGGER")
  (#eq? @function.method.logging.debug "debug"))

(call
  function: (attribute
    object: (identifier) @_logger
    attribute: (identifier) @function.method.logging.info)
  (#any-of? @_logger "logger" "log" "logging" "LOGGER")
  (#eq? @function.method.logging.info "info"))

(call
  function: (attribute
    object: (identifier) @_logger
    attribute: (identifier) @function.method.logging.warning)
  (#any-of? @_logger "logger" "log" "logging" "LOGGER")
  (#eq? @function.method.logging.warning "warning"))

(call
  function: (attribute
    object: (identifier) @_logger
    attribute: (identifier) @function.method.logging.error)
  (#any-of? @_logger "logger" "log" "logging" "LOGGER")
  (#any-of? @function.method.logging.error "error" "critical" "exception"))


; ============================================================================
; 11. EXCEPTIONS — Vollständig
; ============================================================================

; --- Raise mit Typ ---
(raise_statement
  "raise" @keyword.exception.raise
  (call
    function: (identifier) @type.exception))

; --- Raise ohne Argument (re-raise) ---
(raise_statement
  "raise" @keyword.exception.reraise)

; --- Raise from (Exception Chaining) ---
; NOTE: "from" is not an exposed anonymous node in raise_statement.
; Only the cause: field is accessible.
(raise_statement
  cause: (identifier) @variable.exception.cause)

; --- Try ---
(try_statement
  "try" @keyword.exception.try)

; --- Except ---
(except_clause
  "except" @keyword.exception.except)

; --- Except*  (Exception Groups, 3.11+) ---
; NOTE: except_group_clause not available in tree-sitter-python v0.25.0
; (except_group_clause
;   "except*" @keyword.exception.except_group)

; --- Exception-Typ im except ---
(except_clause
  (identifier) @type.exception.caught)

; --- Tuple von Exceptions: except (ValueError, TypeError) ---
(except_clause
  (tuple
    (identifier) @type.exception.caught.tuple))

; --- Exception Alias: except ValueError as e ---
(except_clause
  (as_pattern
    alias: (as_pattern_target
      (identifier) @variable.exception)))

; --- Finally ---
(finally_clause
  "finally" @keyword.exception.finally)

; --- Else in Try ---
(try_statement
  (else_clause
    "else" @keyword.exception.else))


; ============================================================================
; 12. CONTROL FLOW UND ASYNC — Vollständig
; ============================================================================

; --- Async def ---
(function_definition
  "async" @keyword.coroutine.async)

; --- Async for ---
(for_statement
  "async" @keyword.coroutine.async.for)

; --- Async with ---
(with_statement
  "async" @keyword.coroutine.async.with)

; --- Await ---
(await
  "await" @keyword.coroutine.await)

; --- Yield ---
(yield
  "yield" @keyword.coroutine.yield)

; --- With Statement: Kontextvariable ---
(with_clause
  (with_item
    value: (as_pattern
      alias: (as_pattern_target
        (identifier) @variable.context_manager))))

; --- For-Else ---
(for_statement
  (else_clause
    "else" @keyword.loop.else))

; --- While-Else ---
(while_statement
  (else_clause
    "else" @keyword.loop.else))

; --- Conditional Expression (Ternary): x if cond else y ---
(conditional_expression
  "if" @keyword.conditional.ternary.if
  "else" @keyword.conditional.ternary.else)

; --- Walrus Operator: (x := expr) ---
(named_expression
  name: (identifier) @variable.walrus
  ":=" @operator.walrus)

; --- Assert Statement ---
(assert_statement
  "assert" @keyword.assert)

; --- Assert mit Message ---
(assert_statement
  "assert" @keyword.assert
  (string) @string.assert_message)

; --- Pass ---
(pass_statement
  "pass" @keyword.pass)

; --- Break ---
(break_statement
  "break" @keyword.control.break)

; --- Continue ---
(continue_statement
  "continue" @keyword.control.continue)

; --- Return ---
(return_statement
  "return" @keyword.control.return)

; --- Del Statement ---
(delete_statement
  "del" @keyword.del)

; --- Global Statement ---
(global_statement
  "global" @keyword.scope.global
  (identifier) @variable.scope.global)

; --- Nonlocal Statement ---
(nonlocal_statement
  "nonlocal" @keyword.scope.nonlocal
  (identifier) @variable.scope.nonlocal)


; ============================================================================
; 13. PATTERN MATCHING (3.10+) — Vollständig
; ============================================================================

; --- Match ---
(match_statement
  "match" @keyword.match
  subject: (identifier) @variable.match.subject)

; --- Case ---
(case_clause
  "case" @keyword.case)

; --- Capture Pattern: case x: ---
(case_pattern
  (dotted_name
    (identifier) @variable.pattern.capture))

; --- Class Pattern: case Point(x, y): ---
(case_pattern
  (class_pattern
    (dotted_name
      (identifier) @type.pattern.class)))

; --- Mapping Pattern: case {"key": value}: ---
(case_pattern
  (dict_pattern))

; --- Wildcard Pattern: case _: ---
; NOTE: In tree-sitter-python, wildcard _ produces an empty case_pattern
; or a dotted_name with "_" identifier
(case_pattern
  (dotted_name
    (identifier) @variable.pattern.wildcard
    (#eq? @variable.pattern.wildcard "_")))

; --- Star Pattern: case [first, *rest]: ---
(case_pattern
  (splat_pattern
    (identifier) @variable.pattern.star))

; --- Guard: case x if x > 0: ---
(case_clause
  guard: (if_clause
    "if" @keyword.pattern.guard))

; --- OR Pattern: case 1 | 2: ---
(case_pattern
  (union_pattern))

; --- Keyword Pattern in Class Pattern: case Point(x=1): ---
(keyword_pattern
  (identifier) @variable.pattern.keyword)

; --- Value Pattern: case Color.RED: ---
(case_pattern
  (dotted_name
    (identifier) @type.pattern.enum
    (identifier) @variable.pattern.member))


; ============================================================================
; 14. IMPORTS — Vollständig differenziert
; ============================================================================

; --- import module ---
(import_statement
  "import" @keyword.import
  name: (dotted_name
    (identifier) @module.import))

; --- from module import name ---
(import_from_statement
  "from" @keyword.import.from
  module_name: (dotted_name
    (identifier) @module.import.source))

; --- Relative Import Punkte ---
(import_from_statement
  (relative_import
    (import_prefix) @punctuation.import.relative
    (dotted_name
      (identifier) @module.import.relative)))

; --- Importierte Namen ---
(import_from_statement
  name: (dotted_name
    (identifier) @variable.import))

; --- Import Alias ---
(aliased_import
  name: (dotted_name
    (identifier) @variable.import.original)
  alias: (identifier) @variable.import.alias)

; --- Wildcard Import ---
(wildcard_import) @keyword.import.wildcard

; --- __future__ Import ---
(import_from_statement
  module_name: (dotted_name
    (identifier) @module.import.future
    (#eq? @module.import.future "__future__")))

; --- typing Import ---
(import_from_statement
  module_name: (dotted_name
    (identifier) @module.import.typing
    (#eq? @module.import.typing "typing")))


; ============================================================================
; 15. ASSIGNMENTS UND UNPACKING — Differenziert
; ============================================================================

; --- Augmented Assignment Operators ---
(augmented_assignment
  operator: "+=" @operator.assignment.add)

(augmented_assignment
  operator: "-=" @operator.assignment.sub)

(augmented_assignment
  operator: "*=" @operator.assignment.mul)

(augmented_assignment
  operator: "/=" @operator.assignment.div)

(augmented_assignment
  operator: "//=" @operator.assignment.floordiv)

(augmented_assignment
  operator: "%=" @operator.assignment.mod)

(augmented_assignment
  operator: "**=" @operator.assignment.pow)

(augmented_assignment
  operator: "|=" @operator.assignment.or)

(augmented_assignment
  operator: "&=" @operator.assignment.and)

(augmented_assignment
  operator: "^=" @operator.assignment.xor)

(augmented_assignment
  operator: ">>=" @operator.assignment.rshift)

(augmented_assignment
  operator: "<<=" @operator.assignment.lshift)

; --- Tuple Unpacking: a, b = (1, 2) ---
(assignment
  left: (pattern_list
    (identifier) @variable.unpack))

; --- Star Unpacking: a, *b = [1, 2, 3] ---
(assignment
  left: (pattern_list
    (list_splat_pattern
      (identifier) @variable.unpack.star)))

; --- Multiple Assignment: a = b = 5 ---
(assignment
  left: (identifier) @variable.assignment)


; ============================================================================
; 16. SPEZIELLE IDENTIFIER UND KONSTANTEN
; ============================================================================

; --- SCREAMING_SNAKE_CASE ---
((identifier) @constant.convention
  (#lua-match? @constant.convention "^[A-Z][A-Z0-9_]+$"))

; --- Private: _private ---
((identifier) @variable.private
  (#lua-match? @variable.private "^_[a-z]"))

; --- Name-Mangled: __mangled ---
((identifier) @variable.mangled
  (#lua-match? @variable.mangled "^__[a-z]"))

; --- Dunder Variables (nicht Funktionen) ---
((identifier) @variable.dunder
  (#lua-match? @variable.dunder "^__.*__$"))

; --- Bekannte Module-Level Dunders ---
((identifier) @variable.dunder.module
  (#any-of? @variable.dunder.module
    "__name__" "__file__" "__doc__" "__package__"
    "__spec__" "__loader__" "__path__" "__builtins__"
    "__all__" "__slots__" "__version__" "__author__"
    "__cached__" "__annotations__"))

; --- Ellipsis ---
(ellipsis) @constant.builtin.ellipsis

; --- Boolean ---
(true) @boolean.true
(false) @boolean.false

; --- None ---
(none) @constant.builtin.none

; --- Numeric Literals differenziert ---
(integer) @number.integer

(float) @number.float

; --- Hex ---
((integer) @number.hex
  (#lua-match? @number.hex "^0[xX]"))

; --- Binary ---
((integer) @number.binary
  (#lua-match? @number.binary "^0[bB]"))

; --- Octal ---
((integer) @number.octal
  (#lua-match? @number.octal "^0[oO]"))

; --- Complex (Imaginary) ---
((float) @number.complex
  (#lua-match? @number.complex "[jJ]$"))

; --- Unpack Operators in Calls ---
(call
  arguments: (argument_list
    (list_splat
      "*" @operator.unpack.args)))

(call
  arguments: (argument_list
    (dictionary_splat
      "**" @operator.unpack.kwargs)))

; --- Keyword Arguments in Calls ---
(keyword_argument
  name: (identifier) @variable.keyword_argument)

; --- Slice Notation ---
(slice
  ":" @punctuation.slice)

; --- Comments ---
(comment) @comment

; --- Type Comment: # type: ignore ---
((comment) @comment.type
  (#lua-match? @comment.type "^# type:"))

; --- TODO/FIXME/HACK ---
((comment) @comment.todo
  (#lua-match? @comment.todo "TODO"))

((comment) @comment.fixme
  (#lua-match? @comment.fixme "FIXME"))

((comment) @comment.hack
  (#lua-match? @comment.hack "HACK"))

((comment) @comment.note
  (#lua-match? @comment.note "NOTE"))

; --- Test Functions (pytest convention) ---
(function_definition
  name: (identifier) @function.test
  (#lua-match? @function.test "^test_"))

; --- Test Classes ---
(class_definition
  name: (identifier) @type.class.test
  (#lua-match? @type.class.test "^Test"))

; --- Fixture/Setup Methods ---
(function_definition
  name: (identifier) @function.setup
  (#any-of? @function.setup "setUp" "tearDown" "setUpClass" "tearDownClass"))

; --- Comparison Operators differenziert ---
(comparison_operator
  operators: "is" @keyword.operator.is)

(comparison_operator
  operators: "is not" @keyword.operator.is_not)

(comparison_operator
  operators: "in" @keyword.operator.in)

(comparison_operator
  operators: "not in" @keyword.operator.not_in)

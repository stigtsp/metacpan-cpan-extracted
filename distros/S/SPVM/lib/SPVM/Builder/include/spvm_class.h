#ifndef SPVM_CLASS_H
#define SPVM_CLASS_H

#include "spvm_typedecl.h"

enum {
  SPVM_CLASS_C_CATEGORY_CLASS,
  SPVM_CLASS_C_CATEGORY_INTERFACE,
  SPVM_CLASS_C_CATEGORY_MULNUM,
};

struct spvm_class {
  SPVM_OP* op_class;
  SPVM_OP* op_name;
  SPVM_OP* op_extends;
  const char* name;
  const char* module_file;
  const char* module_dir;
  const char* module_rel_file;
  SPVM_TYPE* type;
  SPVM_LIST* class_vars;
  SPVM_HASH* class_var_symtable;
  SPVM_LIST* fields;
  SPVM_HASH* field_symtable;
  SPVM_LIST* tmp_merged_fields;
  SPVM_LIST* methods;
  SPVM_HASH* method_symtable;
  SPVM_LIST* interfaces;
  SPVM_HASH* interface_symtable;
  SPVM_LIST* anon_methods;
  SPVM_LIST* allows;
  SPVM_LIST* interface_decls;
  SPVM_HASH* class_alias_symtable;
  SPVM_METHOD* required_method;
  SPVM_METHOD* destructor_method;
  const char* parent_class_name;
  SPVM_CLASS* parent_class;
  int32_t id;
  int32_t fields_byte_size;
  int8_t has_init_block;
  int8_t is_anon;
  int8_t category;
  int8_t is_precompile;
  int8_t is_pointer;
  int8_t access_control_type;
};

SPVM_CLASS* SPVM_CLASS_new(SPVM_COMPILER* compiler);
const char* const* SPVM_CLASS_C_CATEGORY_NAMES(void);

#endif

using System;
using System.Interop;

namespace jsonc_Beef;

public static class jsonc
{
	typealias char = c_char;
	typealias ssize_t = int;
	typealias json_bool = bool;

	typealias int8_t = int8;
	typealias int16_t = int16;
	typealias int32_t = int32;
	typealias int64_t = int64;

	typealias uint8_t = uint8;
	typealias uint16_t = uint16;
	typealias uint32_t = uint32;
	typealias uint64_t = uint64;

	/*
	* $Id: arraylist.h,v 1.4 2006/01/26 02:16:28 mclark Exp $
	*
	* Copyright (c) 2004, 2005 Metaparadigm Pte. Ltd.
	* Michael Clark <michael@metaparadigm.com>
	*
	* This library is free software; you can redistribute it and/or modify
	* it under the terms of the MIT license. See COPYING for details.
	*
	*/

	/**
	* @file
	* @brief Internal methods for working with json_type_array objects.
	*        Although this is exposed by the json_object_get_array() method,
	*        it is not recommended for direct use.
	*/
	const int ARRAY_LIST_DEFAULT_SIZE = 32;

	public function void array_list_free_fn(void* data);

	[CRepr] public struct array_list
	{
		void** array;
		uint length;
		uint size;
		array_list_free_fn* free_fn;
	}

	/**
	* Allocate an array_list of the default size (32).
	* @deprecated Use array_list_new2() instead.
	*/
	//extern array_list* array_list_new(array_list_free_fn* free_fn);

	/**
	* Allocate an array_list of the desired size.
	*
	* If possible, the size should be chosen to closely match
	* the actual number of elements expected to be used.
	* If the exact size is unknown, there are tradeoffs to be made:
	* - too small - the array_list code will need to call realloc() more
	*   often (which might incur an additional memory copy).
	* - too large - will waste memory, but that can be mitigated
	*   by calling array_list_shrink() once the final size is known.
	*
	* @see array_list_shrink
	*/
	/*extern array_list* array_list_new2(array_list_free_fn* free_fn, int initial_size);

	extern void array_list_free(array_list* al);

	extern void* array_list_get_idx(array_list* al, uint i);

	extern int array_list_insert_idx(array_list* al, uint i, void* data);

	extern int array_list_put_idx(array_list* al, uint i, void* data);

	extern int array_list_add(array_list* al, void* data);

	extern uint array_list_length(array_list* al);

	extern void array_list_sort(array_list* arr, int (* compar) (void*, void*));

	extern void* array_list_bsearch(void** key, array_list* arr, int (* compar) (void*, void*));

	extern int array_list_del_idx(array_list* arr, uint idx, uint count);*/

	/**
	* Shrink the array list to just enough to fit the number of elements in it,
	* plus empty_slots.
	*/
	//extern int array_list_shrink(array_list* arr, uint empty_slots);


	/*
	* $Id: debug.h,v 1.5 2006/01/30 23:07:57 mclark Exp $
	*
	* Copyright (c) 2004, 2005 Metaparadigm Pte. Ltd.
	* Michael Clark <michael@metaparadigm.com>
	* Copyright (c) 2009 Hewlett-Packard Development Company, L.P.
	*
	* This library is free software; you can redistribute it and/or modify
	* it under the terms of the MIT license. See COPYING for details.
	*
	*/

	/**
	* @file
	* @brief Do not use, json-c internal, may be changed or removed at any time.
	*/

	[CLink] public static extern void mc_set_debug(int debug);
	[CLink] public static extern int mc_get_debug(void);

	[CLink] public static extern void mc_set_syslog(int syslog);

	[CLink] public static extern void mc_debug(char* msg, ...);
	[CLink] public static extern void mc_error(char* msg, ...);
	[CLink] public static extern void mc_info(char* msg, ...);

	/*
	* Copyright (c) 2012,2017 Eric Haszlakiewicz
	*
	* This library is free software; you can redistribute it and/or modify
	* it under the terms of the MIT license. See COPYING for details.
	*/

	/**
	* @file
	* @brief Methods for retrieving the json-c version.
	*/

	const int JSON_C_MAJOR_VERSION = 0;
	const int JSON_C_MINOR_VERSION = 18;
	const int JSON_C_MICRO_VERSION = 99;

	/**
	* @see JSON_C_VERSION
	* @return the version of the json-c library as a string
	*/
	[CLink] public static extern char* json_c_version(void); /* Returns JSON_C_VERSION */

	/**
	* The json-c version encoded into an int, with the low order 8 bits
	* being the micro version, the next higher 8 bits being the minor version
	* and the next higher 8 bits being the major version.
	* For example, 7.12.99 would be 0x00070B63.
	*
	* @see JSON_C_VERSION_NUM
	* @return the version of the json-c library as an int
	*/
	[CLink] public static extern int json_c_version_num(void); /* Returns JSON_C_VERSION_NUM */


	/*
	* $Id: json_object.h,v 1.12 2006/01/30 23:07:57 mclark Exp $
	*
	* Copyright (c) 2004, 2005 Metaparadigm Pte. Ltd.
	* Michael Clark <michael@metaparadigm.com>
	* Copyright (c) 2009 Hewlett-Packard Development Company, L.P.
	*
	* This library is free software; you can redistribute it and/or modify
	* it under the terms of the MIT license. See COPYING for details.
	*
	*/

	/**
	* @file
	* @brief Core json-c API.  Start here, or with json_tokener.h
	*/

	[CRepr]
	public enum json_object_int_type
	{
		json_object_int_type_int64,
		json_object_int_type_uint64
	}

	[CRepr]
	public struct json_object
	{
		json_type o_type;
		uint32_t _ref_count;
		json_object_to_json_string_fn* _to_json_string;
		printbuf* _pb;
		json_object_delete_fn* _user_delete;
		void* _userdata;
		// Actually longer, always malloc'd as some more-specific type.
		// The rest of a struct json_object_${o_type} follows
	}

	[CRepr]
	public struct json_object_object
	{
		json_object base_obj;
		lh_table* c_object;
	};

	[CRepr]
	public struct json_object_array
	{
		json_object base_obj;
		array_list* c_array;
	};

	[CRepr]
	public struct json_object_boolean
	{
		json_object base_obj;
		json_bool c_boolean;
	};

	[CRepr]
	public struct json_object_double
	{
		json_object base_obj;
		double c_double;
	};

	[CRepr]
	public struct json_object_int
	{
		json_object base_obj;
		json_object_int_type cint_type;

		/**/ [Union] struct
		{
			int64_t c_int64;
			uint64_t c_uint64;
		} cint;
	};

	[CRepr]
	public struct json_object_string
	{
		json_object base_obj;
		ssize_t len; // Signed b/c negative lengths indicate data is a pointer
		// Consider adding an "alloc" field here, if json_object_set_string calls
		// to expand the length of a string are common operations to perform. [Union] struct

		/**/ [Union] struct
		{
			char[1] idata; // Immediate data.  Actually longer
			char* pdata; // Only when len < 0
		} c_string;
	};

	const int JSON_OBJECT_DEF_HASH_ENTRIES = 16;

	/**
	* A flag for the json_object_to_json_string_ext() and
	* json_object_to_file_ext() functions which causes the output
	* to have no extra whitespace or formatting applied.
	*/
	const int JSON_C_TO_STRING_PLAIN = 0;
	/**
	* A flag for the json_object_to_json_string_ext() and
	* json_object_to_file_ext() functions which causes the output to have
	* minimal whitespace inserted to make things slightly more readable.
	*/
	const int JSON_C_TO_STRING_SPACED = 1 << 0;
	/**
	* A flag for the json_object_to_json_string_ext() and
	* json_object_to_file_ext() functions which causes
	* the output to be formatted.
	*
	* See the "Two Space Tab" option at https://jsonformatter.curiousconcept.com/
	* for an example of the format.
	*/
	const int JSON_C_TO_STRING_PRETTY = 1 << 1;
	/**
	* A flag for the json_object_to_json_string_ext() and
	* json_object_to_file_ext() functions which causes
	* the output to be formatted.
	*
	* Instead of a "Two Space Tab" this gives a single tab character.
	*/
	const int JSON_C_TO_STRING_PRETTY_TAB = 1 << 3;
	/**
	* A flag to drop trailing zero for float values
	*/
	const int JSON_C_TO_STRING_NOZERO = 1 << 2;

	/**
	* Don't escape forward slashes.
	*/
	const int JSON_C_TO_STRING_NOSLASHESCAPE = 1 << 4;

	/**
	* A flag for the json_object_to_json_string_ext() and
	* json_object_to_file_ext() functions which causes
	* the output to be formatted.
	*
	* Use color for printing json.
	*/
	const int JSON_C_TO_STRING_COLOR = 1 << 5;

	/**
	* A flag for the json_object_object_add_ex function which
	* causes the value to be added without a check if it already exists.
	* Note: it is the responsibility of the caller to ensure that no
	* key is added multiple times. If this is done, results are
	* unpredictable. While this option is somewhat dangerous, it
	* permits potentially large performance savings in code that
	* knows for sure the key values are unique (e.g. because the
	* code adds a well-known set of constant key values).
	*/
	const int JSON_C_OBJECT_ADD_KEY_IS_NEW = 1 << 1;
	/**
	* A flag for the json_object_object_add_ex function which
	* flags the key as being constant memory. This means that
	* the key will NOT be copied via strdup(), resulting in a
	* potentially huge performance win (malloc, strdup and
	* free are usually performance hogs). It is acceptable to
	* use this flag for keys in non-constant memory blocks if
	* the caller ensure that the memory holding the key lives
	* longer than the corresponding json object. However, this
	* is somewhat dangerous and should only be done if really
	* justified.
	* The general use-case for this flag is cases where the
	* key is given as a real constant value in the function
	* call, e.g. as in
	*   json_object_object_add_ex(obj, "ip", json,
	*       JSON_C_OBJECT_ADD_CONSTANT_KEY);
	*/
	const int JSON_C_OBJECT_ADD_CONSTANT_KEY = 1 << 2;
	/**
	* This flag is an alias to JSON_C_OBJECT_ADD_CONSTANT_KEY.
	* Historically, this flag was used first and the new name
	* JSON_C_OBJECT_ADD_CONSTANT_KEY was introduced for version
	* 0.16.00 in order to have regular naming.
	* Use of this flag is now legacy.
	*/
	const int JSON_C_OBJECT_KEY_IS_CONSTANT = JSON_C_OBJECT_ADD_CONSTANT_KEY;

	/**
	* Set the global value of an option, which will apply to all
	* current and future threads that have not set a thread-local value.
	*
	* @see json_c_set_serialization_double_format
	*/
	const int JSON_C_OPTION_GLOBAL = 0;
	/**
	* Set a thread-local value of an option, overriding the global value.
	* This will fail if json-c is not compiled with threading enabled, and
	* with the __thread specifier (or equivalent) available.
	*
	* @see json_c_set_serialization_double_format
	*/
	const int JSON_C_OPTION_THREAD = 1;

	 /* reference counting functions */

	 /**
	* Increment the reference count of json_object, thereby taking ownership of it.
	*
	* Cases where you might need to increase the refcount include:
	* - Using an object field or array index (retrieved through
	*    `json_object_object_get()` or `json_object_array_get_idx()`)
	*    beyond the lifetime of the parent object.
	* - Detaching an object field or array index from its parent object
	*    (using `json_object_object_del()` or `json_object_array_del_idx()`)
	* - Sharing a json_object with multiple (not necessarily parallel) threads
	*    of execution that all expect to free it (with `json_object_put()`) when
	*    they're done.
	*
	* @param obj the json_object instance
	* @see json_object_put()
	* @see json_object_object_get()
	* @see json_object_array_get_idx()
	*/
	[CLink] public static extern json_object* json_object_get(json_object* obj);

	/**
	* Decrement the reference count of json_object and free if it reaches zero.
	*
	* You must have ownership of obj prior to doing this or you will cause an
	* imbalance in the reference count, leading to a classic use-after-free bug.
	* In particular, you normally do not need to call `json_object_put()` on the
	* json_object returned by `json_object_object_get()` or `json_object_array_get_idx()`.
	*
	* Just like after calling `free()` on a block of memory, you must not use
	* `obj` after calling `json_object_put()` on it or any object that it
	* is a member of (unless you know you've called `json_object_get(obj)` to
	* explicitly increment the refcount).
	*
	* NULL may be passed, in which case this is a no-op.
	*
	* @param obj the json_object instance
	* @returns 1 if the object was freed, 0 if only the refcount was decremented
	* @see json_object_get()
	*/
	[CLink] public static extern int json_object_put(json_object* obj);

	/**
	* Check if the json_object is of a given type
	* @param obj the json_object instance
	* @param type one of:
		json_type_null (i.e. obj == NULL),
		json_type_boolean,
		json_type_double,
		json_type_int,
		json_type_object,
		json_type_array,
		json_type_string
	* @returns 1 if the object is of the specified type, 0 otherwise
	*/
	[CLink] public static extern int json_object_is_type(json_object* obj, json_type type);

	/**
	* Get the type of the json_object.  See also json_type_to_name() to turn this
	* into a string suitable, for instance, for logging.
	*
	* @param obj the json_object instance
	* @returns type being one of:
		json_type_null (i.e. obj == NULL),
		json_type_boolean,
		json_type_double,
		json_type_int,
		json_type_object,
		json_type_array,
		json_type_string
	*/
	[CLink] public static extern json_type json_object_get_type(json_object* obj);

	/** Stringify object to json format.
	* Equivalent to json_object_to_json_string_ext(obj, JSON_C_TO_STRING_SPACED)
	* The pointer you get is an internal of your json object. You don't
	* have to free it, later use of json_object_put() should be sufficient.
	* If you can not ensure there's no concurrent access to *obj use
	* strdup().
	* @param obj the json_object instance
	* @returns a string in JSON format
	*/
	[CLink] public static extern char* json_object_to_json_string(json_object* obj);

	/** Stringify object to json format
	* @see json_object_to_json_string() for details on how to free string.
	* @param obj the json_object instance
	* @param flags formatting options, see JSON_C_TO_STRING_PRETTY and other constants
	* @returns a string in JSON format
	*/
	[CLink] public static extern char* json_object_to_json_string_ext(json_object* obj, int flags);

	/** Stringify object to json format
	* @see json_object_to_json_string() for details on how to free string.
	* @param obj the json_object instance
	* @param flags formatting options, see JSON_C_TO_STRING_PRETTY and other constants
	* @param length a pointer where, if not NULL, the length (without null) is stored
	* @returns a string in JSON format and the length if not NULL
	*/
	[CLink] public static extern char* json_object_to_json_string_length(json_object* obj, int flags, uint* length);

	/**
	* Returns the userdata set by json_object_set_userdata() or
	* json_object_set_serializer()
	*
	* @param jso the object to return the userdata for
	*/
	[CLink] public static extern void* json_object_get_userdata(json_object* jso);

	/**
	* Set an opaque userdata value for an object
	*
	* The userdata can be retrieved using json_object_get_userdata().
	*
	* If custom userdata is already set on this object, any existing user_delete
	* function is called before the new one is set.
	*
	* The user_delete parameter is optional and may be passed as NULL, even if
	* the userdata parameter is non-NULL.  It will be called just before the
	* json_object is deleted, after it's reference count goes to zero
	* (see json_object_put()).
	* If this is not provided, it is up to the caller to free the userdata at
	* an appropriate time. (i.e. after the json_object is deleted)
	*
	* Note: Objects created by parsing strings may have custom serializers set
	* which expect the userdata to contain specific data (due to use of
	* json_object_new_double_s()). In this case, json_object_set_serialiser() with
	* NULL as to_string_func should be used instead to set the userdata and reset
	* the serializer to its default value.
	*
	* @param jso the object to set the userdata for
	* @param userdata an optional opaque cookie
	* @param user_delete an optional function from freeing userdata
	*/
	[CLink] public static extern void json_object_set_userdata(json_object* jso, void* userdata, json_object_delete_fn* user_delete);

	/**
	* Set a custom serialization function to be used when this particular object
	* is converted to a string by json_object_to_json_string.
	*
	* If custom userdata is already set on this object, any existing user_delete
	* function is called before the new one is set.
	*
	* If to_string_func is NULL the default behaviour is reset (but the userdata
	* and user_delete fields are still set).
	*
	* The userdata parameter is optional and may be passed as NULL. It can be used
	* to provide additional data for to_string_func to use. This parameter may
	* be NULL even if user_delete is non-NULL.
	*
	* The user_delete parameter is optional and may be passed as NULL, even if
	* the userdata parameter is non-NULL.  It will be called just before the
	* json_object is deleted, after it's reference count goes to zero
	* (see json_object_put()).
	* If this is not provided, it is up to the caller to free the userdata at
	* an appropriate time. (i.e. after the json_object is deleted)
	*
	* Note that the userdata is the same as set by json_object_set_userdata(), so
	* care must be taken not to overwrite the value when both a custom serializer
	* and json_object_set_userdata() are used.
	*
	* @param jso the object to customize
	* @param to_string_func the custom serialization function
	* @param userdata an optional opaque cookie
	* @param user_delete an optional function from freeing userdata
	*/
	[CLink] public static extern void json_object_set_serializer(json_object* jso, json_object_to_json_string_fn* to_string_func, void* userdata, json_object_delete_fn* user_delete);

	/**
	* Simply call free on the userdata pointer.
	* Can be used with json_object_set_serializer().
	*
	* @param jso unused
	* @param userdata the pointer that is passed to free().
	*/
	[CLink] public static extern void json_object_delete_fn(json_object* jso, void* userdata);

	/**
	* Copy the jso->_userdata string over to pb as-is.
	* Can be used with json_object_set_serializer().
	*
	* @param jso The object whose _userdata is used.
	* @param pb The destination buffer.
	* @param level Ignored.
	* @param flags Ignored.
	*/
	[CLink] public static extern json_object_to_json_string_fn json_object_userdata_to_json_string;

	/* object type methods */

	/** Create a new empty object with a reference count of 1.  The caller of
	* this object initially has sole ownership.  Remember, when using
	* json_object_object_add or json_object_array_put_idx, ownership will
	* transfer to the object/array.  Call json_object_get if you want to maintain
	* shared ownership or also add this object as a child of multiple objects or
	* arrays.  Any ownerships you acquired but did not transfer must be released
	* through json_object_put.
	*
	* @returns a json_object of type json_type_object
	*/
	[CLink] public static extern json_object* json_object_new_object(void);

	/** Get the hashtable of a json_object of type json_type_object
	* @param obj the json_object instance
	* @returns a linkhash
	*/
	[CLink] public static extern lh_table* json_object_get_object(json_object* obj);

	/** Get the size of an object in terms of the number of fields it has.
	* @param obj the json_object whose length to return
	*/
	[CLink] public static extern int json_object_object_length(json_object* obj);

	/** Get the sizeof (json_object).
	* @returns a uint with the sizeof (json_object)
	*/
	//JSON_C_CONST_FUNCTION([CLink] public static extern uint json_c_object_sizeof(void));

	/** Add an object field to a json_object of type json_type_object
	*
	* The reference count of `val` will *not* be incremented, in effect
	* transferring ownership that object to `obj`, and thus `val` will be
	* freed when `obj` is.  (i.e. through `json_object_put(obj)`)
	*
	* If you want to retain a reference to the added object, independent
	* of the lifetime of obj, you must increment the refcount with
	* `json_object_get(val)` (and later release it with json_object_put()).
	*
	* Since ownership transfers to `obj`, you must make sure
	* that you do in fact have ownership over `val`.  For instance,
	* json_object_new_object() will give you ownership until you transfer it,
	* whereas json_object_object_get() does not.
	*
	* Any previous object stored under `key` in `obj` will have its refcount
	* decremented, and be freed normally if that drops to zero.
	*
	* @param obj the json_object instance
	* @param key the object field name (a private copy will be duplicated)
	* @param val a json_object or NULL member to associate with the given field
	*
	* @return On success, <code>0</code> is returned.
	* 	On error, a negative value is returned.
	*/
	[CLink] public static extern int json_object_object_add(json_object* obj, char* key, json_object* val);

	/** Add an object field to a json_object of type json_type_object
	*
	* The semantics are identical to json_object_object_add, except that an
	* additional flag fields gives you more control over some detail aspects
	* of processing. See the description of JSON_C_OBJECT_ADD_* flags for more
	* details.
	*
	* @param obj the json_object instance
	* @param key the object field name (a private copy will be duplicated)
	* @param val a json_object or NULL member to associate with the given field
	* @param opts process-modifying options. To specify multiple options, use
	*             (OPT1|OPT2)
	*/
	[CLink] public static extern int json_object_object_add_ex(json_object* obj, char* key, json_object* val, uint opts);

	/** Get the json_object associate with a given object field.
	* Deprecated/discouraged: used json_object_object_get_ex instead.
	*
	* This returns NULL if the field is found but its value is null, or if
	*  the field is not found, or if obj is not a json_type_object.  If you
	*  need to distinguish between these cases, use json_object_object_get_ex().
	*
	* *No* reference counts will be changed.  There is no need to manually adjust
	* reference counts through the json_object_put/json_object_get methods unless
	* you need to have the child (value) reference maintain a different lifetime
	* than the owning parent (obj). Ownership of the returned value is retained
	* by obj (do not do json_object_put unless you have done a json_object_get).
	* If you delete the value from obj (json_object_object_del) and wish to access
	* the returned reference afterwards, make sure you have first gotten shared
	* ownership through json_object_get (& don't forget to do a json_object_put
	* or transfer ownership to prevent a memory leak).
	*
	* @param obj the json_object instance
	* @param key the object field name
	* @returns the json_object associated with the given field name
	*/
	[CLink] public static extern json_object* json_object_object_get(json_object* obj, char* key);

	/** Get the json_object associated with a given object field.
	*
	* This returns true if the key is found, false in all other cases (including
	* if obj isn't a json_type_object).
	*
	* *No* reference counts will be changed.  There is no need to manually adjust
	* reference counts through the json_object_put/json_object_get methods unless
	* you need to have the child (value) reference maintain a different lifetime
	* than the owning parent (obj).  Ownership of value is retained by obj.
	*
	* @param obj the json_object instance
	* @param key the object field name
	* @param value a pointer where to store a reference to the json_object
	*              associated with the given field name.
	*
	*              It is safe to pass a NULL value.
	* @returns 1 if the key exists, 0 otherwise
	*/
	[CLink] public static extern int json_object_object_get_ex(json_object* obj, char* key, json_object** value);

	/** Delete the given json_object field
	*
	* The reference count will be decremented for the deleted object.  If there
	* are no more owners of the value represented by this key, then the value is
	* freed.  Otherwise, the reference to the value will remain in memory.
	*
	* @param obj the json_object instance
	* @param key the object field name
	*/
	[CLink] public static extern void json_object_object_del(json_object* obj, char* key);

	/**
	* Iterate through all keys and values of an object.
	*
	* Adding keys to the object while iterating is NOT allowed.
	*
	* Deleting an existing key, or replacing an existing key with a
	* new value IS allowed.
	*
	* @param obj the json_object instance
	* @param key the local name for the char* key variable defined in the body
	* @param val the local name for the json_object* object variable defined in
	*            the body
	*/
	// #if defined(__GNUC__) && !defined(__STRICT_ANSI__) && (defined(__STDC_VERSION__) && __STDC_VERSION__ >= 199901L)

	// #define json_object_object_foreach(obj, key, val)                                \
	// 	char* key = NULL;                                                        \
	// 	json_object* val __attribute__((__unused__)) = NULL;              \
	// 	for (lh_entry *entry##key = lh_table_head(json_object_get_object(obj)),    \
	// 						*entry_next##key = NULL;                            \
	// 		({                                                                  \
	// 			if (entry##key)                                             \
	// 			{                                                           \
	// 				key = (char* )lh_entry_k(entry##key);               \
	// 				val = (json_object* )lh_entry_v(entry##key); \
	// 				entry_next##key = lh_entry_next(entry##key);        \
	// 			};                                                          \
	// 			entry##key;                                                 \
	// 		});                                                                 \
	// 		entry##key = entry_next##key)

	// #else /* ANSI C or MSC */

	// #define json_object_object_foreach(obj, key, val)                              \
	// 	char* key = NULL;                                                      \
	// 	json_object* val = NULL;                                        \
	// 	struct lh_entry *entry##key;                                           \
	// 	struct lh_entry *entry_next##key = NULL;                               \
	// 	for (entry##key = lh_table_head(json_object_get_object(obj));          \
	// 		(entry##key ? (key = (char* )lh_entry_k(entry##key),              \
	// 					val = (json_object* )lh_entry_v(entry##key), \
	// 					entry_next##key = lh_entry_next(entry##key), entry##key)     \
	// 					: 0);                                                 \
	// 		entry##key = entry_next##key)

	// #endif /* defined(__GNUC__) && !defined(__STRICT_ANSI__) && (defined(__STDC_VERSION__) && __STDC_VERSION__ >= 199901L) */

	/** Iterate through all keys and values of an object (ANSI C Safe)
	* @param obj the json_object instance
	* @param iter the object iterator, use type json_object_iter
	*/
	// #define json_object_object_foreachC(obj, iter)                                                  \
	// 	for (iter.entry = lh_table_head(json_object_get_object(obj));                                    \
	// 		(iter.entry ? (iter.key = (char* )lh_entry_k(iter.entry),                          \
	// 					iter.val = (json_object* )lh_entry_v(iter.entry), iter.entry) \
	// 					: 0);                                                                  \
	// 		iter.entry = lh_entry_next(iter.entry))

	/* Array type methods */

	/** Create a new empty json_object of type json_type_array
	* with 32 slots allocated.
	* If you know the array size you'll need ahead of time, use
	* json_object_new_array_ext() instead.
	* @see json_object_new_array_ext()
	* @see json_object_array_shrink()
	* @returns a json_object of type json_type_array
	*/
	[CLink] public static extern json_object* json_object_new_array(void);

	/** Create a new empty json_object of type json_type_array
	* with the desired number of slots allocated.
	* @see json_object_array_shrink()
	* @param initial_size the number of slots to allocate
	* @returns a json_object of type json_type_array
	*/
	[CLink] public static extern json_object* json_object_new_array_ext(int initial_size);

	/** Get the arraylist of a json_object of type json_type_array
	* @param obj the json_object instance
	* @returns an arraylist
	*/
	[CLink] public static extern array_list* json_object_get_array(json_object* obj);

	/** Get the length of a json_object of type json_type_array
	* @param obj the json_object instance
	* @returns the length of the array
	*/
	[CLink] public static extern uint json_object_array_length(json_object* obj);

	/** Sorts the elements of jso of type json_type_array
	*
	* Pointers to the json_object pointers will be passed as the two arguments
	* to sort_fn
	*
	* @param jso the json_object instance
	* @param sort_fn a sorting function
	*/
	[CLink] public static extern void json_object_array_sort(json_object* jso, function int(void*, void*) sort_fn);

	/** Binary search a sorted array for a specified key object.
	*
	* It depends on your compare function what's sufficient as a key.
	* Usually you create some dummy object with the parameter compared in
	* it, to identify the right item you're actually looking for.
	*
	* @see json_object_array_sort() for hints on the compare function.
	*
	* @param key a dummy json_object with the right key
	* @param jso the array object we're searching
	* @param sort_fn the sort/compare function
	*
	* @return the wanted json_object instance
	*/
	[CLink] public static extern json_object* json_object_array_bsearch(json_object* key, json_object* jso, function int(void*, void*) sort_fn);

	/** Add an element to the end of a json_object of type json_type_array
	*
	* The reference count will *not* be incremented. This is to make adding
	* fields to objects in code more compact. If you want to retain a reference
	* to an added object you must wrap the passed object with json_object_get
	*
	* @param obj the json_object instance
	* @param val the json_object to be added
	*/
	[CLink] public static extern int json_object_array_add(json_object* obj, json_object* val);

	/** Insert or replace an element at a specified index in an array (a json_object of type json_type_array)
	*
	* The reference count will *not* be incremented. This is to make adding
	* fields to objects in code more compact. If you want to retain a reference
	* to an added object you must wrap the passed object with json_object_get
	*
	* The reference count of a replaced object will be decremented.
	*
	* The array size will be automatically be expanded to the size of the
	* index if the index is larger than the current size.
	*
	* @param obj the json_object instance
	* @param idx the index to insert the element at
	* @param val the json_object to be added
	*/
	[CLink] public static extern int json_object_array_put_idx(json_object* obj, uint idx, json_object* val);

	/** Insert an element at a specified index in an array (a json_object of type json_type_array)
	*
	* The reference count will *not* be incremented. This is to make adding
	* fields to objects in code more compact. If you want to retain a reference
	* to an added object you must wrap the passed object with json_object_get
	*
	* The array size will be automatically be expanded to the size of the
	* index if the index is larger than the current size.
	* If the index is within the existing array limits, then the element will be
	* inserted and all elements will be shifted. This is the only difference between
	* this function and json_object_array_put_idx().
	*
	* @param obj the json_object instance
	* @param idx the index to insert the element at
	* @param val the json_object to be added
	*/
	[CLink] public static extern int json_object_array_insert_idx(json_object* obj, uint idx, json_object* val);

	/** Get the element at specified index of array `obj` (which must be a json_object of type json_type_array)
	*
	* *No* reference counts will be changed, and ownership of the returned
	* object remains with `obj`.  See json_object_object_get() for additional
	* implications of this behavior.
	*
	* Calling this with anything other than a json_type_array will trigger
	* an assert.
	*
	* @param obj the json_object instance
	* @param idx the index to get the element at
	* @returns the json_object at the specified index (or NULL)
	*/
	[CLink] public static extern json_object* json_object_array_get_idx(json_object* obj, uint idx);

	/** Delete an elements from a specified index in an array (a json_object of type json_type_array)
	*
	* The reference count will be decremented for each of the deleted objects.  If there
	* are no more owners of an element that is being deleted, then the value is
	* freed.  Otherwise, the reference to the value will remain in memory.
	*
	* @param obj the json_object instance
	* @param idx the index to start deleting elements at
	* @param count the number of elements to delete
	* @returns 0 if the elements were successfully deleted
	*/
	[CLink] public static extern int json_object_array_del_idx(json_object* obj, uint idx, uint count);

	/**
	* Shrink the internal memory allocation of the array to just
	* enough to fit the number of elements in it, plus empty_slots.
	*
	* @param jso the json_object instance, must be json_type_array
	* @param empty_slots the number of empty slots to leave allocated
	*/
	[CLink] public static extern int json_object_array_shrink(json_object* jso, int empty_slots);

	/* json_bool type methods */

	/** Create a new empty json_object of type json_type_boolean
	* @param b a json_bool 1 or 0
	* @returns a json_object of type json_type_boolean
	*/
	[CLink] public static extern json_object* json_object_new_boolean(json_bool b);

	/** Get the json_bool value of a json_object
	*
	* The type is coerced to a json_bool if the passed object is not a json_bool.
	* integer and double objects will return 0 if there value is zero
	* or 1 otherwise. If the passed object is a string it will return
	* 1 if it has a non zero length.
	* If any other object type is passed 0 will be returned, even non-empty
	*  json_type_array and json_type_object objects.
	*
	* @param obj the json_object instance
	* @returns a json_bool
	*/
	[CLink] public static extern json_bool json_object_get_boolean(json_object* obj);

	/** Set the json_bool value of a json_object
	*
	* The type of obj is checked to be a json_type_boolean and 0 is returned
	* if it is not without any further actions. If type of obj is json_type_boolean
	* the object value is changed to new_value
	*
	* @param obj the json_object instance
	* @param new_value the value to be set
	* @returns 1 if value is set correctly, 0 otherwise
	*/
	[CLink] public static extern int json_object_set_boolean(json_object* obj, json_bool new_value);

	/* int type methods */

	/** Create a new empty json_object of type json_type_int
	* Note that values are stored as 64-bit values internally.
	* To ensure the full range is maintained, use json_object_new_int64 instead.
	* @param i the integer
	* @returns a json_object of type json_type_int
	*/
	[CLink] public static extern json_object* json_object_new_int(int32_t i);

	/** Create a new empty json_object of type json_type_int
	* @param i the integer
	* @returns a json_object of type json_type_int
	*/
	[CLink] public static extern json_object* json_object_new_int64(int64_t i);

	/** Create a new empty json_object of type json_type_uint
	* @param i the integer
	* @returns a json_object of type json_type_uint
	*/
	[CLink] public static extern json_object* json_object_new_uint64(uint64_t i);

	/** Get the int value of a json_object
	*
	* The type is coerced to a int if the passed object is not a int.
	* double objects will return their integer conversion except for NaN values
	* which return INT32_MIN and the errno is set to EINVAL.
	* Strings will be parsed as an integer. If no conversion exists then 0 is
	* returned and errno is set to EINVAL. null is equivalent to 0 (no error values
	* set).
	* Sets errno to ERANGE if the value exceeds the range of int.
	*
	* Note that integers are stored internally as 64-bit values.
	* If the value of too big or too small to fit into 32-bit, INT32_MAX or
	* INT32_MIN are returned, respectively.
	*
	* @param obj the json_object instance
	* @returns an int
	*/
	[CLink] public static extern int32_t json_object_get_int(json_object* obj);

	/** Set the int value of a json_object
	*
	* The type of obj is checked to be a json_type_int and 0 is returned
	* if it is not without any further actions. If type of obj is json_type_int
	* the object value is changed to new_value
	*
	* @param obj the json_object instance
	* @param new_value the value to be set
	* @returns 1 if value is set correctly, 0 otherwise
	*/
	[CLink] public static extern int json_object_set_int(json_object* obj, int new_value);

	/** Increment a json_type_int object by the given amount, which may be negative.
	*
	* If the type of obj is not json_type_int then 0 is returned with no further
	* action taken.
	* If the addition would result in a overflow, the object value
	* is set to INT64_MAX.
	* If the addition would result in a underflow, the object value
	* is set to INT64_MIN.
	* Neither overflow nor underflow affect the return value.
	*
	* @param obj the json_object instance
	* @param val the value to add
	* @returns 1 if the increment succeeded, 0 otherwise
	*/
	[CLink] public static extern int json_object_int_inc(json_object* obj, int64_t val);

	/** Get the int value of a json_object
	*
	* The type is coerced to a int64 if the passed object is not a int64.
	* double objects will return their int64 conversion except for NaN values
	* which return INT64_MIN and the errno is set to EINVAL.
	* Strings will be parsed as an int64. If no conversion exists then 0 is
	* returned and errno is set to EINVAL. null is equivalent to 0 (no error values
	* set).
	* Sets errno to ERANGE if the value exceeds the range of int64.
	*
	* NOTE: Set errno to 0 directly before a call to this function to determine
	* whether or not conversion was successful (it does not clear the value for
	* you).
	*
	* @param obj the json_object instance
	* @returns an int64
	*/
	[CLink] public static extern int64_t json_object_get_int64(json_object* obj);

	/** Get the uint value of a json_object
	*
	* The type is coerced to a uint64 if the passed object is not a uint64.
	* double objects will return their uint64 conversion except for NaN values
	* which return 0 and the errno is set to EINVAL.
	* Strings will be parsed as an uint64. If no conversion exists then 0 is
	* returned and errno is set to EINVAL. null is equivalent to 0 (no error values
	* set).
	* Sets errno to ERANGE if the value exceeds the range of uint64.
	*
	* NOTE: Set errno to 0 directly before a call to this function to determine
	* whether or not conversion was successful (it does not clear the value for
	* you).
	*
	* @param obj the json_object instance
	* @returns an uint64
	*/
	[CLink] public static extern uint64_t json_object_get_uint64(json_object* obj);

	/** Set the int64_t value of a json_object
	*
	* The type of obj is checked to be a json_type_int and 0 is returned
	* if it is not without any further actions. If type of obj is json_type_int
	* the object value is changed to new_value
	*
	* @param obj the json_object instance
	* @param new_value the value to be set
	* @returns 1 if value is set correctly, 0 otherwise
	*/
	[CLink] public static extern int json_object_set_int64(json_object* obj, int64_t new_value);

	/** Set the uint64_t value of a json_object
	*
	* The type of obj is checked to be a json_type_uint and 0 is returned
	* if it is not without any further actions. If type of obj is json_type_uint
	* the object value is changed to new_value
	*
	* @param obj the json_object instance
	* @param new_value the value to be set
	* @returns 1 if value is set correctly, 0 otherwise
	*/
	[CLink] public static extern int json_object_set_uint64(json_object* obj, uint64_t new_value);

	/* double type methods */

	/** Create a new empty json_object of type json_type_double
	*
	* @see json_object_double_to_json_string() for how to set a custom format string.
	*
	* @param d the double
	* @returns a json_object of type json_type_double
	*/
	[CLink] public static extern json_object* json_object_new_double(double d);

	/**
	* Create a new json_object of type json_type_double, using
	* the exact serialized representation of the value.
	*
	* This allows for numbers that would otherwise get displayed
	* inefficiently (e.g. 12.3 => "12.300000000000001") to be
	* serialized with the more convenient form.
	*
	* Notes:
	*
	* This is used by json_tokener_parse_ex() to allow for
	* an exact re-serialization of a parsed object.
	*
	* The userdata field is used to store the string representation, so it
	* can't be used for other data if this function is used.
	*
	* A roughly equivalent sequence of calls, with the difference being that
	*  the serialization function won't be reset by json_object_set_double(), is:
	* @code
	*   jso = json_object_new_double(d);
	*   json_object_set_serializer(jso, json_object_userdata_to_json_string,
	*       strdup(ds), json_object_free_userdata);
	* @endcode
	*
	* @param d the numeric value of the double.
	* @param ds the string representation of the double.  This will be copied.
	*/
	[CLink] public static extern json_object* json_object_new_double_s(double d, char* ds);

	/**
	* Set a global or thread-local json-c option, depending on whether
	*  JSON_C_OPTION_GLOBAL or JSON_C_OPTION_THREAD is passed.
	* Thread-local options default to undefined, and inherit from the global
	*  value, even if the global value is changed after the thread is created.
	* Attempting to set thread-local options when threading is not compiled in
	*  will result in an error.  Be sure to check the return value.
	*
	* double_format is a "%g" printf format, such as "%.20g"
	*
	* @return -1 on errors, 0 on success.
	*/
	[CLink] public static extern int json_c_set_serialization_double_format(char* double_format,
		int global_or_thread);

	/** Serialize a json_object of type json_type_double to a string.
	*
	* This function isn't meant to be called directly. Instead, you can set a
	* custom format string for the serialization of this double using the
	* following call (where "%.17g" actually is the default):
	*
	* @code
	*   jso = json_object_new_double(d);
	*   json_object_set_serializer(jso, json_object_double_to_json_string,
	*       "%.17g", NULL);
	* @endcode
	*
	* @see printf(3) man page for format strings
	*
	* @param jso The json_type_double object that is serialized.
	* @param pb The destination buffer.
	* @param level Ignored.
	* @param flags Ignored.
	*/
	[CLink] public static extern int json_object_double_to_json_string(json_object* jso, printbuf* pb, int level, int flags);

	/** Get the double floating point value of a json_object
	*
	* The type is coerced to a double if the passed object is not a double.
	* integer objects will return their double conversion. Strings will be
	* parsed as a double. If no conversion exists then 0.0 is returned and
	* errno is set to EINVAL. null is equivalent to 0 (no error values set)
	*
	* If the value is too big to fit in a double, then the value is set to
	* the closest infinity with errno set to ERANGE. If strings cannot be
	* converted to their double value, then EINVAL is set & NaN is returned.
	*
	* Arrays of length 0 are interpreted as 0 (with no error flags set).
	* Arrays of length 1 are effectively cast to the equivalent object and
	* converted using the above rules.  All other arrays set the error to
	* EINVAL & return NaN.
	*
	* NOTE: Set errno to 0 directly before a call to this function to
	* determine whether or not conversion was successful (it does not clear
	* the value for you).
	*
	* @param obj the json_object instance
	* @returns a double floating point number
	*/
	[CLink] public static extern double json_object_get_double(json_object* obj);

	/** Set the double value of a json_object
	*
	* The type of obj is checked to be a json_type_double and 0 is returned
	* if it is not without any further actions. If type of obj is json_type_double
	* the object value is changed to new_value
	*
	* If the object was created with json_object_new_double_s(), the serialization
	* function is reset to the default and the cached serialized value is cleared.
	*
	* @param obj the json_object instance
	* @param new_value the value to be set
	* @returns 1 if value is set correctly, 0 otherwise
	*/
	[CLink] public static extern int json_object_set_double(json_object* obj, double new_value);

	/* string type methods */

	/** Create a new empty json_object of type json_type_string
	*
	* A copy of the string is made and the memory is managed by the json_object
	*
	* @param s the string
	* @returns a json_object of type json_type_string
	* @see json_object_new_string_len()
	*/
	[CLink] public static extern json_object* json_object_new_string(char* s);

	/** Create a new empty json_object of type json_type_string and allocate
	* len characters for the new string.
	*
	* A copy of the string is made and the memory is managed by the json_object
	*
	* @param s the string
	* @param len max length of the new string
	* @returns a json_object of type json_type_string
	* @see json_object_new_string()
	*/
	[CLink] public static extern json_object* json_object_new_string_len(char* s, int len);

	/** Get the string value of a json_object
	*
	* If the passed object is of type json_type_null (i.e. obj == NULL),
	* NULL is returned.
	*
	* If the passed object of type json_type_string, the string contents
	* are returned.
	*
	* Otherwise the JSON representation of the object is returned.
	*
	* The returned string memory is managed by the json_object and will
	* be freed when the reference count of the json_object drops to zero.
	*
	* @param obj the json_object instance
	* @returns a string or NULL
	*/
	[CLink] public static extern char* json_object_get_string(json_object* obj);

	/** Get the string length of a json_object
	*
	* If the passed object is not of type json_type_string then zero
	* will be returned.
	*
	* @param obj the json_object instance
	* @returns int
	*/
	[CLink] public static extern int json_object_get_string_len(json_object* obj);

	/** Set the string value of a json_object with zero terminated strings
	* equivalent to json_object_set_string_len (obj, new_value, strlen(new_value))
	* @returns 1 if value is set correctly, 0 otherwise
	*/
	[CLink] public static extern int json_object_set_string(json_object* obj, char* new_value);

	/** Set the string value of a json_object str
	*
	* The type of obj is checked to be a json_type_string and 0 is returned
	* if it is not without any further actions. If type of obj is json_type_string
	* the object value is changed to new_value
	*
	* @param obj the json_object instance
	* @param new_value the value to be set; Since string length is given in len this need not be zero terminated
	* @param len the length of new_value
	* @returns 1 if value is set correctly, 0 otherwise
	*/
	[CLink] public static extern int json_object_set_string_len(json_object* obj, char* new_value, int len);

	/** This method exists only to provide a complementary function
	* along the lines of the other json_object_new_* functions.
	* It always returns NULL, and it is entirely acceptable to simply use NULL directly.
	*/
	[CLink] public static extern json_object* json_object_new_null(void);

	/** Check if two json_object's are equal
	*
	* If the passed objects are equal 1 will be returned.
	* Equality is defined as follows:
	* - json_objects of different types are never equal
	* - json_objects of the same primitive type are equal if the
	*   c-representation of their value is equal
	* - json-arrays are considered equal if all values at the same
	*   indices are equal (same order)
	* - Complex json_objects are considered equal if all
	*   contained objects referenced by their key are equal,
	*   regardless their order.
	*
	* @param obj1 the first json_object instance
	* @param obj2 the second json_object instance
	* @returns 1 if both objects are equal, 0 otherwise
	*/
	[CLink] public static extern int json_object_equal(json_object* obj1, json_object* obj2);

	/**
	* Perform a shallow copy of src into *dst as part of an overall json_object_deep_copy().
	*
	* If src is part of a containing object or array, parent will be non-NULL,
	* and key or index will be provided.
	* When shallow_copy is called *dst will be NULL, and must be non-NULL when it returns.
	* src will never be NULL.
	*
	* If shallow_copy sets the serializer on an object, return 2 to indicate to
	*  json_object_deep_copy that it should not attempt to use the standard userdata
	*  copy function.
	*
	* @return On success 1 or 2, -1 on errors
	*/
	public function int json_c_shallow_copy_fn(json_object* src, json_object* parent, char* key, uint index, json_object** dst);

	/**
	* The default shallow copy implementation for use with json_object_deep_copy().
	* This simply calls the appropriate json_object_new_<type>() function and
	* copies over the serializer function (_to_json_string internal field of
	* the json_object structure) but not any _userdata or _user_delete values.
	*
	* If you're writing a custom shallow_copy function, perhaps because you're using
	* your own custom serializer, you can call this first to create the new object
	* before customizing it with json_object_set_serializer().
	*
	* @return 1 on success, -1 on errors, but never 2.
	*/
	[CLink] public static extern int json_c_shallow_copy_default(json_object* src, json_object* parent, char* key, uint index, json_object** dst);

	/**
	* Copy the contents of the JSON object.
	* The destination object must be initialized to NULL,
	* to make sure this function won't overwrite an existing JSON object.
	*
	* This does roughly the same thing as
	* `json_tokener_parse(json_object_get_string(src))`.
	*
	* @param src source JSON object whose contents will be copied
	* @param dst pointer to the destination object where the contents of `src`;
	*            make sure this pointer is initialized to NULL
	* @param shallow_copy an optional function to copy individual objects, needed
	*                     when custom serializers are in use.  See also
	*                     json_object set_serializer.
	*
	* @returns 0 if the copy went well, -1 if an error occurred during copy
	*          or if the destination pointer is non-NULL
	*/

	[CLink] public static extern int json_object_deep_copy(json_object* src, json_object** dst, json_c_shallow_copy_fn* shallow_copy);
	/**
	*******************************************************************************
	* @file json_object_iterator.h
	*
	* Copyright (c) 2009-2012 Hewlett-Packard Development Company, L.P.
	*
	* This library is free software; you can redistribute it and/or modify
	* it under the terms of the MIT license. See COPYING for details.
	*
	* @brief  An API for iterating over json_type_object objects,
	*         styled to be familiar to C++ programmers.
	*         Unlike json_object_object_foreach() and
	*         json_object_object_foreachC(), this avoids the need to expose
	*         json-c internals like lh_entry.
	*
	* API attributes: <br>
	*   * Thread-safe: NO<br>
	*   * Reentrant: NO
	*
	*******************************************************************************
	*/

	/**
	* The opaque iterator that references a name/value pair within
	* a JSON Object instance or the "end" iterator value.
	*/
	[CRepr]
	public struct json_object_iterator
	{
		void* opaque_;
	};

	/**
	* Initializes an iterator structure to a "default" value that
	* is convenient for initializing an iterator variable to a
	* default state (e.g., initialization list in a class'
	* constructor).
	*
	* @code
	* struct json_object_iterator iter = json_object_iter_init_default();
	* MyClass() : iter_(json_object_iter_init_default())
	* @endcode
	*
	* @note The initialized value doesn't reference any specific
	*       pair, is considered an invalid iterator, and MUST NOT
	*       be passed to any json-c API that expects a valid
	*       iterator.
	*
	* @note User and internal code MUST NOT make any assumptions
	*       about and dependencies on the value of the "default"
	*       iterator value.
	*
	* @return json_object_iterator
	*/
	[CLink] public static extern json_object_iterator json_object_iter_init_default(void);

	/** Retrieves an iterator to the first pair of the JSON Object.
	*
	* @warning 	Any modification of the underlying pair invalidates all
	* 		iterators to that pair.
	*
	* @param obj	JSON Object instance (MUST be of type json_object)
	*
	* @return json_object_iterator If the JSON Object has at
	*              least one pair, on return, the iterator refers
	*              to the first pair. If the JSON Object doesn't
	*              have any pairs, the returned iterator is
	*              equivalent to the "end" iterator for the same
	*              JSON Object instance.
	*
	* @code
	* struct json_object_iterator it;
	* struct json_object_iterator itEnd;
	* json_object* obj;
	*
	* obj = json_tokener_parse("{'first':'george', 'age':100}");
	* it = json_object_iter_begin(obj);
	* itEnd = json_object_iter_end(obj);
	*
	* while (!json_object_iter_equal(&it, &itEnd)) {
	*     printf("%s\n",
	*            json_object_iter_peek_name(&it));
	*     json_object_iter_next(&it);
	* }
	*
	* @endcode
	*/
	[CLink] public static extern json_object_iterator json_object_iter_begin(json_object* obj);

	/** Retrieves the iterator that represents the position beyond the
	*  last pair of the given JSON Object instance.
	*
	*  @warning Do NOT write code that assumes that the "end"
	*        iterator value is NULL, even if it is so in a
	*        particular instance of the implementation.
	*
	*  @note The reason we do not (and MUST NOT) provide
	*        "json_object_iter_is_end(json_object_iterator* iter)"
	*        type of API is because it would limit the underlying
	*        representation of name/value containment (or force us
	*        to add additional, otherwise unnecessary, fields to
	*        the iterator structure). The "end" iterator and the
	*        equality test method, on the other hand, permit us to
	*        cleanly abstract pretty much any reasonable underlying
	*        representation without burdening the iterator
	*        structure with unnecessary data.
	*
	*  @note For performance reasons, memorize the "end" iterator prior
	*        to any loop.
	*
	* @param obj JSON Object instance (MUST be of type json_object)
	*
	* @return json_object_iterator On return, the iterator refers
	*              to the "end" of the Object instance's pairs
	*              (i.e., NOT the last pair, but "beyond the last
	*              pair" value)
	*/
	[CLink] public static extern json_object_iterator json_object_iter_end(json_object* obj);

	/** Returns an iterator to the next pair, if any
	*
	* @warning	Any modification of the underlying pair
	*       	invalidates all iterators to that pair.
	*
	* @param iter [IN/OUT] Pointer to iterator that references a
	*         name/value pair; MUST be a valid, non-end iterator.
	*         WARNING: bad things will happen if invalid or "end"
	*         iterator is passed. Upon return will contain the
	*         reference to the next pair if there is one; if there
	*         are no more pairs, will contain the "end" iterator
	*         value, which may be compared against the return value
	*         of json_object_iter_end() for the same JSON Object
	*         instance.
	*/
	[CLink] public static extern void json_object_iter_next(json_object_iterator* iter);

	/** Returns a const pointer to the name of the pair referenced
	*  by the given iterator.
	*
	* @param iter pointer to iterator that references a name/value
	*             pair; MUST be a valid, non-end iterator.
	*
	* @warning	bad things will happen if an invalid or
	*             	"end" iterator is passed.
	*
	* @return char* Pointer to the name of the referenced
	*         name/value pair.  The name memory belongs to the
	*         name/value pair, will be freed when the pair is
	*         deleted or modified, and MUST NOT be modified or
	*         freed by the user.
	*/
	[CLink] public static extern char* json_object_iter_peek_name(json_object_iterator* iter);

	/** Returns a pointer to the json-c instance representing the
	*  value of the referenced name/value pair, without altering
	*  the instance's reference count.
	*
	* @param iter 	pointer to iterator that references a name/value
	*             	pair; MUST be a valid, non-end iterator.
	*
	* @warning	bad things will happen if invalid or
	*             "end" iterator is passed.
	*
	* @return json_object* Pointer to the json-c value
	*         instance of the referenced name/value pair;  the
	*         value's reference count is not changed by this
	*         function: if you plan to hold on to this json-c node,
	*         take a look at json_object_get() and
	*         json_object_put(). IMPORTANT: json-c API represents
	*         the JSON Null value as a NULL json_object instance
	*         pointer.
	*/
	[CLink] public static extern json_object* json_object_iter_peek_value(json_object_iterator* iter);

	/** Tests two iterators for equality.  Typically used to test
	*  for end of iteration by comparing an iterator to the
	*  corresponding "end" iterator (that was derived from the same
	*  JSON Object instance).
	*
	*  @note The reason we do not (and MUST NOT) provide
	*        "json_object_iter_is_end(json_object_iterator* iter)"
	*        type of API is because it would limit the underlying
	*        representation of name/value containment (or force us
	*        to add additional, otherwise unnecessary, fields to
	*        the iterator structure). The equality test method, on
	*        the other hand, permits us to cleanly abstract pretty
	*        much any reasonable underlying representation.
	*
	* @param iter1 Pointer to first valid, non-NULL iterator
	* @param iter2 POinter to second valid, non-NULL iterator
	*
	* @warning	if a NULL iterator pointer or an uninitialized
	*       	or invalid iterator, or iterators derived from
	*       	different JSON Object instances are passed, bad things
	*       	will happen!
	*
	* @return json_bool non-zero if iterators are equal (i.e., both
	*         reference the same name/value pair or are both at
	*         "end"); zero if they are not equal.
	*/
	[CLink] public static extern json_bool json_object_iter_equal(json_object_iterator* iter1, json_object_iterator* iter2);

	/*
	* Copyright (c) 2021 Alexadru Ardelean.
	*
	* This is free software; you can redistribute it and/or modify
	* it under the terms of the MIT license. See COPYING for details.
	*
	*/

	/**
	* @file
	* @brief JSON Patch (RFC 6902) implementation for manipulating JSON objects
	*/

	/**
	* Details of an error that occurred during json_patch_apply()
	*/
	[CRepr]
	public struct json_patch_error
	{
		/**
		* An errno value indicating what kind of error occurred.
		* Possible values include:
		* - ENOENT - A path referenced in the operation does not exist.
		* - EINVAL - An invalid operation or with invalid path was attempted
		* - ENOMEM - Unable to allocate memory
		* - EFAULT - Invalid arguments were passed to json_patch_apply()
		*             (i.e. a C API error, vs. a data error like EINVAL)
		*/
		int errno_code;

		/**
		* The index into the patch array of the operation that failed,
		* or uint_MAX for overall errors.
		*/
		uint patch_failure_idx;

		/**
		* A human readable error message.
		* Allocated from static storage, does not need to be freed.
		*/
		char* errmsg;
	}

	/**
	* Apply the JSON patch to the base object.
	* The patch object must be formatted as per RFC 6902, i.e.
	* a json_type_array containing patch operations.
	* If the patch is not correctly formatted, an error will
	* be returned.
	*
	* The json_object at *base will be modified in place.
	* Exactly one of *base or copy_from must be non-NULL.
	* If *base is NULL, a new copy of copy_from will allocated and populated
	* using json_object_deep_copy().  In this case json_object_put() _must_ be 
	* used to free *base even if the overall patching operation fails.
	*
	* If anything fails during patching a negative value will be returned,
	* and patch_error (if non-NULL) will be populated with error details.
	*
	* @param base a pointer to the JSON object which to patch
	* @param patch the JSON object that describes the patch to be applied
	* @param copy_from a JSON object to copy to *base
	* @param patch_error optional, details about errors
	*
	* @return negative if an error (or not found), or 0 if patch completely applied
	*/
	[CLink] public static extern int json_patch_apply(json_object* copy_from, json_object* patch, json_object** base_obj, json_patch_error* patch_error);

	/*
	* Copyright (c) 2016 Alexadru Ardelean.
	*
	* This is free software; you can redistribute it and/or modify
	* it under the terms of the MIT license. See COPYING for details.
	*
	*/

	/**
	* @file
	* @brief JSON Pointer (RFC 6901) implementation for retrieving
	*        objects from a json-c object tree.
	*/

	/**
	* Retrieves a JSON sub-object from inside another JSON object
	* using the JSON pointer notation as defined in RFC 6901
	*   https://tools.ietf.org/html/rfc6901
	*
	* The returned JSON sub-object is equivalent to parsing manually the
	* 'obj' JSON tree ; i.e. it's not a new object that is created, but rather
	* a pointer inside the JSON tree.
	*
	* Internally, this is equivalent to doing a series of 'json_object_object_get()'
	* and 'json_object_array_get_idx()' along the given 'path'.
	*
	* @param obj the json_object instance/tree from where to retrieve sub-objects
	* @param path a (RFC6901) string notation for the sub-object to retrieve
	* @param res a pointer that stores a reference to the json_object
	*              associated with the given path
	*
	* @return negative if an error (or not found), or 0 if succeeded
	*/
	[CLink] public static extern int json_pointer_get(json_object* obj, char* path, json_object** res);

	/**
	* This is a variant of 'json_pointer_get()' that supports printf() style arguments.
	*
	* Variable arguments go after the 'path_fmt' parameter.
	*
	* Example: json_pointer_getf(obj, res, "/foo/%d/%s", 0, "bar")
	* This also means that you need to escape '%' with '%%' (just like in printf())
	*
	* Please take into consideration all recommended 'printf()' format security
	* aspects when using this function.
	*
	* @param obj the json_object instance/tree to which to add a sub-object
	* @param res a pointer that stores a reference to the json_object
	*              associated with the given path
	* @param path_fmt a printf() style format for the path
	*
	* @return negative if an error (or not found), or 0 if succeeded
	*/
	[CLink] public static extern int json_pointer_getf(json_object* obj, json_object** res, char* path_fmt, ...);

	/**
	* Sets JSON object 'value' in the 'obj' tree at the location specified
	* by the 'path'. 'path' is JSON pointer notation as defined in RFC 6901
	*   https://tools.ietf.org/html/rfc6901
	*
	* Note that 'obj' is a double pointer, mostly for the "" (empty string)
	* case, where the entire JSON object would be replaced by 'value'.
	* In the case of the "" path, the object at '*obj' will have it's refcount
	* decremented with 'json_object_put()' and the 'value' object will be assigned to it.
	*
	* For other cases (JSON sub-objects) ownership of 'value' will be transferred into
	* '*obj' via 'json_object_object_add()' & 'json_object_array_put_idx()', so the
	* only time the refcount should be decremented for 'value' is when the return value of
	* 'json_pointer_set()' is negative (meaning the 'value' object did not get set into '*obj').
	*
	* That also implies that 'json_pointer_set()' does not do any refcount incrementing.
	* (Just that single decrement that was mentioned above).
	*
	* @param obj the json_object instance/tree to which to add a sub-object
	* @param path a (RFC6901) string notation for the sub-object to set in the tree
	* @param value object to set at path
	*
	* @return negative if an error (or not found), or 0 if succeeded
	*/
	[CLink] public static extern int json_pointer_set(json_object** obj, char* path, json_object* value);

	/**
	* This is a variant of 'json_pointer_set()' that supports printf() style arguments.
	*
	* Variable arguments go after the 'path_fmt' parameter.
	*
	* Example: json_pointer_setf(obj, value, "/foo/%d/%s", 0, "bar")
	* This also means that you need to escape '%' with '%%' (just like in printf())
	*
	* Please take into consideration all recommended 'printf()' format security
	* aspects when using this function.
	*
	* @param obj the json_object instance/tree to which to add a sub-object
	* @param value object to set at path
	* @param path_fmt a printf() style format for the path
	*
	* @return negative if an error (or not found), or 0 if succeeded
	*/
	[CLink] public static extern int json_pointer_setf(json_object** obj, json_object* value, char* path_fmt, ...);

	/*
	* $Id: json_tokener.h,v 1.10 2006/07/25 03:24:50 mclark Exp $
	*
	* Copyright (c) 2004, 2005 Metaparadigm Pte. Ltd.
	* Michael Clark <michael@metaparadigm.com>
	*
	* This library is free software; you can redistribute it and/or modify
	* it under the terms of the MIT license. See COPYING for details.
	*
	*/

	/**
	* @file
	* @brief Methods to parse an input string into a tree of json_object objects.
	*/
	[CRepr]
	public enum json_tokener_error
	{
		json_tokener_success,
		json_tokener_continue,
		json_tokener_error_depth,
		json_tokener_error_parse_eof,
		json_tokener_error_parse_unexpected,
		json_tokener_error_parse_null,
		json_tokener_error_parse_boolean,
		json_tokener_error_parse_number,
		json_tokener_error_parse_array,
		json_tokener_error_parse_object_key_name,
		json_tokener_error_parse_object_key_sep,
		json_tokener_error_parse_object_value_sep,
		json_tokener_error_parse_string,
		json_tokener_error_parse_comment,
		json_tokener_error_parse_utf8_string,
		json_tokener_error_size, /* A string longer than INT32_MAX was passed as input */
		json_tokener_error_memory /* Failed to allocate memory */
	}

	/**
	* @deprecated Don't use this outside of json_tokener.c, it will be made private in a future release.
	*/
	[CRepr]
	public enum json_tokener_state
	{
		json_tokener_state_eatws,
		json_tokener_state_start,
		json_tokener_state_finish,
		json_tokener_state_null,
		json_tokener_state_comment_start,
		json_tokener_state_comment,
		json_tokener_state_comment_eol,
		json_tokener_state_comment_end,
		json_tokener_state_string,
		json_tokener_state_string_escape,
		json_tokener_state_escape_unicode,
		json_tokener_state_escape_unicode_need_escape,
		json_tokener_state_escape_unicode_need_u,
		json_tokener_state_boolean,
		json_tokener_state_number,
		json_tokener_state_array,
		json_tokener_state_array_add,
		json_tokener_state_array_sep,
		json_tokener_state_object_field_start,
		json_tokener_state_object_field,
		json_tokener_state_object_field_end,
		json_tokener_state_object_value,
		json_tokener_state_object_value_add,
		json_tokener_state_object_sep,
		json_tokener_state_array_after_sep,
		json_tokener_state_object_field_start_after_sep,
		json_tokener_state_inf
	}

	/**
	* @deprecated Don't use this outside of json_tokener.c, it will be made private in a future release.
	*/
	[CRepr]
	struct json_tokener_srec
	{
		json_tokener_state state, saved_state;
		json_object* obj;
		json_object* current;
		char* obj_field_name;
	}

	const int JSON_TOKENER_DEFAULT_DEPTH = 32;

	/**
	* Internal state of the json parser.
	* Do not access any fields of this structure directly.
	* Its definition is published due to historical limitations
	* in the json tokener API, and will be changed to be an opaque
	* type in the future.
	*/
	[CRepr]
	public struct json_tokener
	{
	/**
	* @deprecated Do not access any of these fields outside of json_tokener.c
	*/
		char* str;
		printbuf* pb;
		int max_depth, depth, is_double, st_pos;
	/**
	* @deprecated See json_tokener_get_parse_end() instead.
	*/
		int char_offset;
	/**
	* @deprecated See json_tokener_get_error() instead.
	*/
		json_tokener_error err;
		uint ucs_char, high_surrogate;
		char quote_char;
		json_tokener_srec* stack;
		int flags;
	}

	/**
	* Return the offset of the byte after the last byte parsed
	* relative to the start of the most recent string passed in
	* to json_tokener_parse_ex().  i.e. this is where parsing
	* would start again if the input contains another JSON object
	* after the currently parsed one.
	*
	* Note that when multiple parse calls are issued, this is *not* the
	* total number of characters parsed.
	*
	* In the past this would have been accessed as tok->char_offset.
	*
	* See json_tokener_parse_ex() for an example of how to use this.
	*/
	public static extern uint json_tokener_get_parse_end(json_tokener* tok);

	/**
	* Be strict when parsing JSON input.  Use caution with
	* this flag as what is considered valid may become more
	* restrictive from one release to the next, causing your
	* code to fail on previously working input.
	*
	* Note that setting this will also effectively disable parsing
	* of multiple json objects in a single character stream
	* (e.g. {"foo":123}{"bar":234}); if you want to allow that
	* also set JSON_TOKENER_ALLOW_TRAILING_CHARS
	*
	* This flag is not set by default.
	*
	* @see json_tokener_set_flags()
	*/
	const int JSON_TOKENER_STRICT = 0x01;

	/**
	* Use with JSON_TOKENER_STRICT to allow trailing characters after the
	* first parsed object.
	*
	* @see json_tokener_set_flags()
	*/
	const int JSON_TOKENER_ALLOW_TRAILING_CHARS = 0x02;

	/**
	* Cause json_tokener_parse_ex() to validate that input is UTF8.
	* If this flag is specified and validation fails, then
	* json_tokener_get_error(tok) will return
	* json_tokener_error_parse_utf8_string
	*
	* This flag is not set by default.
	*
	* @see json_tokener_set_flags()
	*/
	const int JSON_TOKENER_VALIDATE_UTF8 = 0x10;

	/**
	* Given an error previously returned by json_tokener_get_error(),
	* return a human readable description of the error.
	*
	* @return a generic error message is returned if an invalid error value is provided.
	*/
	[CLink] public static extern char* json_tokener_error_desc(json_tokener_error jerr);

	/**
	* Retrieve the error caused by the last call to json_tokener_parse_ex(),
	* or json_tokener_success if there is no error.
	*
	* When parsing a JSON string in pieces, if the tokener is in the middle
	* of parsing this will return json_tokener_continue.
	*
	* @see json_tokener_error_desc().
	*/
	[CLink] public static extern json_tokener_error json_tokener_get_error(json_tokener* tok);

	/**
	* Allocate a new json_tokener.
	* When done using that to parse objects, free it with json_tokener_free().
	* See json_tokener_parse_ex() for usage details.
	*/
	[CLink] public static extern json_tokener* json_tokener_new(void);

	/**
	* Allocate a new json_tokener with a custom max nesting depth.
	* The depth must be at least 1.
	* @see JSON_TOKENER_DEFAULT_DEPTH
	*/
	[CLink] public static extern json_tokener* json_tokener_new_ex(int depth);

	/**
	* Free a json_tokener previously allocated with json_tokener_new().
	*/
	[CLink] public static extern void json_tokener_free(json_tokener* tok);

	/**
	* Reset the state of a json_tokener, to prepare to parse a 
	* brand new JSON object.
	*/
	[CLink] public static extern void json_tokener_reset(json_tokener* tok);

	/**
	* Parse a json_object out of the string `str`.
	*
	* If you need more control over how the parsing occurs,
	* see json_tokener_parse_ex().
	*/
	[CLink] public static extern json_object* json_tokener_parse(char* str);

	/**
	* Parse a json_object out of the string `str`, but if it fails
	* return the error in `*error`.
	* @see json_tokener_parse()
	* @see json_tokener_parse_ex()
	*/
	[CLink] public static extern json_object* json_tokener_parse_verbose(char* str, json_tokener_error* error);

	/**
	* Set flags that control how parsing will be done.
	*/
	[CLink] public static extern void json_tokener_set_flags(json_tokener* tok, int flags);

	/**
	* Parse a string and return a non-NULL json_object if a valid JSON value
	* is found.  The string does not need to be a JSON object or array;
	* it can also be a string, number or boolean value.
	*
	* A partial JSON string can be parsed.  If the parsing is incomplete,
	* NULL will be returned and json_tokener_get_error() will return
	* json_tokener_continue.
	* json_tokener_parse_ex() can then be called with additional bytes in str
	* to continue the parsing.
	*
	* If json_tokener_parse_ex() returns NULL and the error is anything other than
	* json_tokener_continue, a fatal error has occurred and parsing must be
	* halted.  Then, the tok object must not be reused until json_tokener_reset()
	* is called.
	*
	* When a valid JSON value is parsed, a non-NULL json_object will be
	* returned, with a reference count of one which belongs to the caller.  Also,
	* json_tokener_get_error() will return json_tokener_success. Be sure to check
	* the type with json_object_is_type() or json_object_get_type() before using
	* the object.
	*
	* Trailing characters after the parsed value do not automatically cause an
	* error.  It is up to the caller to decide whether to treat this as an
	* error or to handle the additional characters, perhaps by parsing another
	* json value starting from that point.
	*
	* If the caller knows that they are at the end of their input, the length
	* passed MUST include the final '\0' character, so values with no inherent
	* end (i.e. numbers) can be properly parsed, rather than just returning
	* json_tokener_continue.
	*
	* Extra characters can be detected by comparing the value returned by
	* json_tokener_get_parse_end() against
	* the length of the last len parameter passed in.
	*
	* The tokener does \b not maintain an internal buffer so the caller is
	* responsible for a subsequent call to json_tokener_parse_ex with an 
	* appropriate str parameter starting with the extra characters.
	*
	* This interface is presently not 64-bit clean due to the int len argument
	* so the function limits the maximum string size to INT32_MAX (2GB).
	* If the function is called with len == -1 then strlen is called to check
	* the string length is less than INT32_MAX (2GB)
	*
	* Example:
	* @code
	json_object* jobj = NULL;
	char* mystring = NULL;
	int stringlen = 0;
	enum json_tokener_error jerr;
	do {
		mystring = ...  // get JSON string, e.g. read from file, etc...
		stringlen = strlen(mystring);
		if (end_of_input)
			stringlen++;  // Include the '\0' if we know we're at the end of input
		jobj = json_tokener_parse_ex(tok, mystring, stringlen);
	} while ((jerr = json_tokener_get_error(tok)) == json_tokener_continue);
	if (jerr != json_tokener_success)
	{
		fprintf(stderr, "Error: %s\n", json_tokener_error_desc(jerr));
		// Handle errors, as appropriate for your application.
	}
	if (json_tokener_get_parse_end(tok) < stringlen)
	{
		// Handle extra characters after parsed object as desired.
		// e.g. issue an error, parse another object from that point, etc...
	}
	// Success, use jobj here.

	@endcode
	*
	* @param tok a json_tokener previously allocated with json_tokener_new()
	* @param str an string with any valid JSON expression, or portion of.  This does not need to be null terminated.
	* @param len the length of str
	*/
	[CLink] public static extern json_object* json_tokener_parse_ex(json_tokener* tok, char* str, int len);

	/**
 * A structure to use with json_object_object_foreachC() loops.
 * Contains key, val and entry members.
 */
	[CRepr]
	public struct json_object_iter
	{
		char* key;
		json_object* val;
		lh_entry* entry;
	}

	/**
	 * @brief The core type for all type of JSON objects handled by json-c
	 */

	/**
	 * Type of custom user delete functions.  See json_object_set_serializer.
	 */
	public function void json_object_delete_fn(json_object* jso, void* userdata);

	/**
	 * Type of a custom serialization function.  See json_object_set_serializer.
	 */
	public function int json_object_to_json_string_fn(json_object* jso, printbuf* pb, int level, int flags);

	/* supported object types */

	[CRepr]
	public enum json_type
	{
		/* If you change this, be sure to update json_type_to_name() too */
		json_type_null,
		json_type_boolean,
		json_type_double,
		json_type_int,
		json_type_object,
		json_type_array,
		json_type_string
	}

		/*
		* $Id: json_util.h,v 1.4 2006/01/30 23:07:57 mclark Exp $
		*
		* Copyright (c) 2004, 2005 Metaparadigm Pte. Ltd.
		* Michael Clark <michael@metaparadigm.com>
		*
		* This library is free software; you can redistribute it and/or modify
		* it under the terms of the MIT license. See COPYING for details.
		*
		*/

		/**
		* @file
		* @brief Miscllaneous utility functions and macros.
		*/

	const int JSON_FILE_BUF_SIZE = 4096;

		/* utility functions */
		/**
		* Read the full contents of the given file, then convert it to a
		* json_object using json_tokener_parse().
		*
		* Returns NULL on failure.  See json_util_get_last_err() for details.
		*/
	[CLink] public static extern json_object* json_object_from_file(char* filename);

		/**
		* Create a JSON object from already opened file descriptor.
		*
		* This function can be helpful, when you opened the file already,
		* e.g. when you have a temp file.
		* Note, that the fd must be readable at the actual position, i.e.
		* use lseek(fd, 0, SEEK_SET) before.
		*
		* The depth argument specifies the maximum object depth to pass to
		* json_tokener_new_ex().  When depth == -1, JSON_TOKENER_DEFAULT_DEPTH
		* is used instead.
		*
		* Returns NULL on failure.  See json_util_get_last_err() for details.
		*/
	[CLink] public static extern json_object* json_object_from_fd_ex(int fd, int depth);

		/**
		* Create a JSON object from an already opened file descriptor, using
		* the default maximum object depth. (JSON_TOKENER_DEFAULT_DEPTH)
		*
		* See json_object_from_fd_ex() for details.
		*/
	[CLink] public static extern json_object* json_object_from_fd(int fd);

		/**
		* Equivalent to:
		*   json_object_to_file_ext(filename, obj, JSON_C_TO_STRING_PLAIN);
		*
		* Returns -1 if something fails.  See json_util_get_last_err() for details.
		*/
	[CLink] public static extern int json_object_to_file(char* filename, json_object* obj);

		/**
		* Open and truncate the given file, creating it if necessary, then
		* convert the json_object to a string and write it to the file.
		*
		* Returns -1 if something fails.  See json_util_get_last_err() for details.
		*/
	[CLink] public static extern int json_object_to_file_ext(char* filename, json_object* obj, int flags);

		/**
		* Convert the json_object to a string and write it to the file descriptor.
		* Handles partial writes and will keep writing until done, or an error
		* occurs.
		*
		* @param fd an open, writable file descriptor to write to
		* @param obj the object to serializer and write
		* @param flags flags to pass to json_object_to_json_string_ext()
		* @return -1 if something fails.  See json_util_get_last_err() for details.
		*/
	[CLink] public static extern int json_object_to_fd(int fd, json_object* obj, int flags);

		/**
		* Return the last error from various json-c functions, including:
		* json_object_to_file{,_ext}, json_object_to_fd() or
		* json_object_from_{file,fd}, or NULL if there is none.
		*/
	[CLink] public static extern char* json_util_get_last_err(void);

		/**
		* A parsing helper for integer values.  Returns 0 on success,
		* with the parsed value assigned to *retval.  Overflow/underflow
		* are NOT considered errors, but errno will be set to ERANGE,
		* just like the strtol/strtoll functions do.
		*/
	[CLink] public static extern int json_parse_int64(char* buf, int64_t* retval);
		/**
		* A parsing help for integer values, providing one extra bit of 
		* magnitude beyond json_parse_int64().
		*/
	[CLink] public static extern int json_parse_uint64(char* buf, uint64_t* retval);
		/**
		* @deprecated
		*/
	[CLink] public static extern int json_parse_double(char* buf, double* retval);

		/**
		* Return a string describing the type of the object.
		* e.g. "int", or "object", etc...
		*/
	[CLink] public static extern char* json_type_to_name(json_type o_type);

		/*
		 * $Id: printbuf.h,v 1.4 2006/01/26 02:16:28 mclark Exp $
		 *
		 * Copyright (c) 2004, 2005 Metaparadigm Pte. Ltd.
		 * Michael Clark <michael@metaparadigm.com>
		 *
		 * This library is free software; you can redistribute it and/or modify
		 * it under the terms of the MIT license. See COPYING for details.
		 *
		 *
		 * Copyright (c) 2008-2009 Yahoo! Inc.  All rights reserved.
		 * The copyrights to the contents of this file are licensed under the MIT License
		 * (https://www.opensource.org/licenses/mit-license.php)
		 */

		/**
		 * @file
		 * @brief Internal string buffer handling.  Unless you're writing a
		 *        json_object_to_json_string_fn implementation for use with
		 *        json_object_set_serializer() direct use of this is not
		 *        recommended.
		 */

	[CRepr]
	public struct printbuf
	{
		char* buf;
		int bpos;
		int size;
	};


	[CLink] public static extern printbuf* printbuf_new(void);

	/* As an optimization, printbuf_memappend_fast() is defined as a macro
	 * that handles copying data if the buffer is large enough; otherwise
	 * it invokes printbuf_memappend() which performs the heavy
	 * lifting of realloc()ing the buffer and copying data.
	 *
	 * Your code should not use printbuf_memappend() directly unless it
	 * checks the return code. Use printbuf_memappend_fast() instead.
	 */
	[CLink] public static extern int printbuf_memappend(printbuf* p, char* buf, int size);

		/*#define printbuf_memappend_fast(p, bufptr, bufsize)                  \
		do                                                           \
		{                                                            \
			if ((p->size - p->bpos) > bufsize)                   \
			{                                                    \
				memcpy(p->buf + p->bpos, (bufptr), bufsize); \
				p->bpos += bufsize;                          \
				p->buf[p->bpos] = '\0';                      \
			}                                                    \
			else                                                 \
			{                                                    \
				printbuf_memappend(p, (bufptr), bufsize);    \
			}                                                    \
		} while (0)*/

	//#define printbuf_length(p) ((p)->bpos)

	/**
	 * Results in a compile error if the argument is not a string literal.
	 */
	//#define _printbuf_check_literal(mystr) ("" mystr)

	/**
	 * This is an optimization wrapper around printbuf_memappend() that is useful
	 * for appending string literals. Since the size of string constants is known
	 * at compile time, using this macro can avoid a costly strlen() call. This is
	 * especially helpful when a constant string must be appended many times. If
	 * you got here because of a compilation error caused by passing something
	 * other than a string literal, use printbuf_memappend_fast() in conjunction
	 * with strlen().
	 *
	 * See also:
	 *   printbuf_memappend_fast()
	 *   printbuf_memappend()
	 *   sprintbuf()
	 */
	/*#define printbuf_strappend(pb, str) \
			printbuf_memappend((pb), _printbuf_check_literal(str), sizeof(str) - 1)*/

	/**
	 * Set len bytes of the buffer to charvalue, starting at offset offset.
	 * Similar to calling memset(x, charvalue, len);
	 *
	 * The memory allocated for the buffer is extended as necessary.
	 *
	 * If offset is -1, this starts at the end of the current data in the buffer.
	 */
	[CLink] public static extern int printbuf_memset(printbuf* pb, int offset, int charvalue, int len);

	/**
	 * Formatted print to printbuf.
	 *
	 * This function is the most expensive of the available functions for appending
	 * string data to a printbuf and should be used only where convenience is more
	 * important than speed. Avoid using this function in high performance code or
	 * tight loops; in these scenarios, consider using snprintf() with a static
	 * buffer in conjunction with one of the printbuf_*append() functions.
	 *
	 * See also:
	 *   printbuf_memappend_fast()
	 *   printbuf_memappend()
	 *   printbuf_strappend()
	 */
	[CLink] public static extern int sprintbuf(printbuf* p,  char* msg, ...);

	[CLink] public static extern void printbuf_reset(printbuf* p);

	[CLink] public static extern void printbuf_free(printbuf* p);


	/*
	* $Id: linkhash.h,v 1.6 2006/01/30 23:07:57 mclark Exp $
	*
	* Copyright (c) 2004, 2005 Metaparadigm Pte. Ltd.
	* Michael Clark <michael@metaparadigm.com>
	* Copyright (c) 2009 Hewlett-Packard Development Company, L.P.
	*
	* This library is free software; you can redistribute it and/or modify
	* it under the terms of the MIT license. See COPYING for details.
	*
	*/

	/**
	* @file
	* @brief Internal methods for working with json_type_object objects.  Although
	*        this is exposed by the json_object_get_object() function and within the
	*        json_object_iter type, it is not recommended for direct use.
	*/

	/**
	* golden prime used in hash functions
	*/
	const int LH_PRIME = 0x9e370001UL;

		   /**
	* The fraction of filled hash buckets until an insert will cause the table
	* to be resized.
	* This can range from just above 0 up to 1.0.
	*/
	const float LH_LOAD_FACTOR = 0.66f;

		   /**
	* sentinel pointer value for empty slots
	*/
	const void* LH_EMPTY = (void*)-1;

	/**
	* sentinel pointer value for freed slots
	*/
	const void* LH_FREED = (void*)-2;

	/**
	* default string hash function
	*/
	const int JSON_C_STR_HASH_DFLT = 0;

	/**
	* perl-like string hash function
	*/
	const int JSON_C_STR_HASH_PERLLIKE = 1;

	/**
	* This function sets the hash function to be used for strings.
	* Must be one of the JSON_C_STR_HASH_* values.
	* @returns 0 - ok, -1 if parameter was invalid
	*/
	//int json_global_set_string_hash(const int h);

	//struct lh_entry;

	/**
	* callback function prototypes
	*/
	function void lh_entry_free_fn(lh_entry* e);
	/**
	* callback function prototypes
	*/
	function int64 lh_hash_fn(void* k);
	/**
	* callback function prototypes
	*/
	function int lh_equal_fn(void* k1, void* k2);

	/**
	* An entry in the hash table.  Outside of linkhash.c, treat this as opaque.
	*/
	[CRepr]
	public struct lh_entry
	{
		/**
		* The key.
		* @deprecated Use lh_entry_k() instead of accessing this directly.
		*/
		void* k;
		/**
		* A flag for users of linkhash to know whether or not they
		* need to free k.
		* @deprecated use lh_entry_k_is_constant() instead.
		*/
		int k_is_constant;
		/**
		* The value.
		* @deprecated Use lh_entry_v() instead of accessing this directly.
		*/
		void* v;
		/**
		* The next entry.
		* @deprecated Use lh_entry_next() instead of accessing this directly.
		*/
		lh_entry* next;
		/**
		* The previous entry.
		* @deprecated Use lh_entry_prev() instead of accessing this directly.
		*/
		lh_entry* prev;
	}

	/**
	* The hash table structure.  Outside of linkhash.c, treat this as opaque.
	*/
	[CRepr]
	public struct lh_table
	{
		/**
		* Size of our hash.
		* @deprecated do not use outside of linkhash.c
		*/
		int size;
		/**
		* Numbers of entries.
		* @deprecated Use lh_table_length() instead.
		*/
		int count;

		/**
		* The first entry.
		* @deprecated Use lh_table_head() instead.
		*/
		lh_entry* head;

		/**
		* The last entry.
		* @deprecated Do not use, may be removed in a future release.
		*/
		lh_entry* tail;

		/**
		* Internal storage of the actual table of entries.
		* @deprecated do not use outside of linkhash.c
		*/
		lh_entry* table;

		/**
		* A pointer to the function responsible for freeing an entry.
		* @deprecated do not use outside of linkhash.c
		*/
		lh_entry_free_fn* free_fn;
		/**
		* @deprecated do not use outside of linkhash.c
		*/
		lh_hash_fn* hash_fn;
		/**
		* @deprecated do not use outside of linkhash.c
		*/
		lh_equal_fn* equal_fn;
	}


	/**
	* Convenience list iterator.
	*/
	// #define lh_foreach(table, entry) for (entry = lh_table_head(table); entry; entry = lh_entry_next(entry))

	/**
	* lh_foreach_safe allows calling of deletion routine while iterating.
	*
	* @param table a struct lh_table*  to iterate over
	* @param entry a struct lh_entry * variable to hold each element
	* @param tmp a struct lh_entry * variable to hold a temporary pointer to the next element
	*/
	// #define lh_foreach_safe(table, entry, tmp) \
	// 	for (entry = lh_table_head(table); entry && ((tmp = lh_entry_next(entry)) || 1); entry = tmp)

	/**
	* Create a new linkhash table.
	*
	* @param size initial table size. The table is automatically resized
	* although this incurs a performance penalty.
	* @param free_fn callback function used to free memory for entries
	* when lh_table_free or lh_table_delete is called.
	* If NULL is provided, then memory for keys and values
	* must be freed by the caller.
	* @param hash_fn  function used to hash keys. 2 standard ones are defined:
	* lh_ptr_hash and lh_char_hash for hashing pointer values
	* and C strings respectively.
	* @param equal_fn comparison function to compare keys. 2 standard ones defined:
	* lh_ptr_hash and lh_char_hash for comparing pointer values
	* and C strings respectively.
	* @return On success, a pointer to the new linkhash table is returned.
	* 	On error, a null pointer is returned.
	*/
	//extern lh_table* lh_table_new(int size, lh_entry_free_fn* free_fn, lh_hash_fn* hash_fn, lh_equal_fn* equal_fn);

	/**
	* Convenience function to create a new linkhash table with char keys.
	*
	* @param size initial table size.
	* @param free_fn callback function used to free memory for entries.
	* @return On success, a pointer to the new linkhash table is returned.
	* 	On error, a null pointer is returned.
	*/
	//extern lh_table* lh_kchar_table_new(int size, lh_entry_free_fn* free_fn);

	/**
	* Convenience function to create a new linkhash table with ptr keys.
	*
	* @param size initial table size.
	* @param free_fn callback function used to free memory for entries.
	* @return On success, a pointer to the new linkhash table is returned.
	* 	On error, a null pointer is returned.
	*/
	//extern lh_table* lh_kptr_table_new(int size, lh_entry_free_fn* free_fn);

	/**
	* Free a linkhash table.
	*
	* If a lh_entry_free_fn callback free function was provided then it is
	* called for all entries in the table.
	*
	* @param t table to free.
	*/
	//extern void lh_table_free(lh_table* t);

	/**
	* Insert a record into the table.
	*
	* @param t the table to insert into.
	* @param k a pointer to the key to insert.
	* @param v a pointer to the value to insert.
	*
	* @return On success, <code>0</code> is returned.
	* 	On error, a negative value is returned.
	*/
	//extern int lh_table_insert(lh_table* t, void* k, void* v);

	/**
	* Insert a record into the table using a precalculated key hash.
	*
	* The hash h, which should be calculated with lh_get_hash() on k, is provided by
	*  the caller, to allow for optimization when multiple operations with the same
	*  key are known to be needed.
	*
	* @param t the table to insert into.
	* @param k a pointer to the key to insert.
	* @param v a pointer to the value to insert.
	* @param h hash value of the key to insert
	* @param opts if set to JSON_C_OBJECT_ADD_CONSTANT_KEY, sets lh_entry.k_is_constant
	*             so t's free function knows to avoid freeing the key.
	*/
	//extern int lh_table_insert_w_hash(lh_table* t, void* k, void* v, unsigned long h, unsigned opts);

	/**
	* Lookup a record in the table.
	*
	* @param t the table to lookup
	* @param k a pointer to the key to lookup
	* @return a pointer to the record structure of the value or NULL if it does not exist.
	*/
	//extern lh_entry* lh_table_lookup_entry(lh_table* t, void* k);

	/**
	* Lookup a record in the table using a precalculated key hash.
	*
	* The hash h, which should be calculated with lh_get_hash() on k, is provided by
	*  the caller, to allow for optimization when multiple operations with the same
	*  key are known to be needed.
	*
	* @param t the table to lookup
	* @param k a pointer to the key to lookup
	* @param h hash value of the key to lookup
	* @return a pointer to the record structure of the value or NULL if it does not exist.
	*/
	//extern lh_entry* lh_table_lookup_entry_w_hash(lh_table* t, void* k, unsigned long h);

	/**
	* Lookup a record in the table.
	*
	* @param t the table to lookup
	* @param k a pointer to the key to lookup
	* @param v a pointer to a where to store the found value (set to NULL if it doesn't exist).
	* @return whether or not the key was found
	*/
	//extern json_bool lh_table_lookup_ex(lh_table* t, void* k, void** v);

	/**
	* Delete a record from the table.
	*
	* If a callback free function is provided then it is called for the
	* for the item being deleted.
	* @param t the table to delete from.
	* @param e a pointer to the entry to delete.
	* @return 0 if the item was deleted.
	* @return -1 if it was not found.
	*/
	//extern int lh_table_delete_entry(lh_table* t, lh_entry* e);

	/**
	* Delete a record from the table.
	*
	* If a callback free function is provided then it is called for the
	* for the item being deleted.
	* @param t the table to delete from.
	* @param k a pointer to the key to delete.
	* @return 0 if the item was deleted.
	* @return -1 if it was not found.
	*/
	//extern int lh_table_delete(lh_table* t, void* k);

	/**
	* Return the number of entries in the table.
	*/
	//extern int lh_table_length(lh_table* t);

	/**
	* Resizes the specified table.
	*
	* @param t Pointer to table to resize.
	* @param new_size New table size. Must be positive.
	*
	* @return On success, <code>0</code> is returned.
	* 	On error, a negative value is returned.
	*/
	//int lh_table_resize(lh_table* t, int new_size);
}
cmake_minimum_required( VERSION 3.10 )

project( libmacho )

set( LIBMACHO_PUBLIC_HEADERS
        architecture.h
        base.h
        context.h
        core.h
        data_model.h
        export.h
        exports_trie.h
        indirect_symbol_table.h
        load_command.h
        load_command_build_version.h
        load_command_code_signature.h
        load_command_data_in_code.h
        load_command_dsymtab.h
        load_command_dyld_chained_fixups.h
        load_command_dyld_environment.h
        load_command_dyld_exports_trie.h
        load_command_dyld_info.h
        load_command_dyld_info_only.h
        load_command_dylib_code_sign_drs.h
        load_command_encryption_info.h
        load_command_encryption_info_64.h
        load_command_function_starts.h
        load_command_id_dylib.h
        load_command_id_dylinker.h
        load_command_lazy_load_dylib.h
        load_command_linker_option.h
        load_command_load_dylib.h
        load_command_load_dylinker.h
        load_command_load_upward_dylib.h
        load_command_load_weak_dylib.h
        load_command_main.h
        load_command_note.h
        load_command_prebind_cksum.h
        load_command_reexport_dylib.h
        load_command_routines.h
        load_command_routines_64.h
        load_command_rpath.h
        load_command_segment.h
        load_command_segment_64.h
        load_command_segment_split_info.h
        load_command_source_version.h
        load_command_sub_client.h
        load_command_sub_framework.h
        load_command_sub_library.h
        load_command_symtab.h
        load_command_twolevel_hints.h
        load_command_uuid.h
        load_command_version_min_iphoneos.h
        load_command_version_min_macosx.h
        load_command_version_min_tvos.h
        load_command_version_min_watchos.h
        logging.h
        macho.h
        macho_abi.h
        macho_image.h
        memory_map.h
        memory_map_self.h
        memory_map_task.h
        memory_object.h
        section.h
        segment.h
        string_table.h
        symbol.h
        symbol_table.h
        PARENT_SCOPE )

set( LIBMACHO_PRIVATE_HEADERS
        _load_command_dyld_info.h
        _load_command_dylib.h
        _load_command_dylinker.h
        _load_command_linkedit.h
        _mach_lcstr.h
        _mach_trie.h
        core_internal.h
        data_model_internal.h
        export_internal.h
        exports_trie_internal.h
        indirect_symbol_table_internal.h
        internal.h
        load_command_internal.h
        logging_internal.h
        macho_abi_internal.h
        macho_image_internal.h
        memory_map_internal.h
        memory_object_internal.h
        section_internal.h
        segment_internal.h
        string_table_internal.h
        symbol_internal.h
        symbol_table_internal.h
        PARENT_SCOPE )

set( SOURCE_FILES
        _load_command_dyld_info.c
        _load_command_dylib.c
        _load_command_dylinker.c
        _load_command_linkedit.c
        _mach_lcstr.c
        _mach_trie.c
        architecture.c
        context.c
        core.c
        data_model.c
        export.c
        exports_trie.c
        indirect_symbol_table.c
        load_command.c
        load_command_build_version.c
        load_command_code_signature.c
        load_command_data_in_code.c
        load_command_dsymtab.c
        load_command_dyld_chained_fixups.c
        load_command_dyld_environment.c
        load_command_dyld_exports_trie.c
        load_command_dyld_info.c
        load_command_dyld_info_only.c
        load_command_dylib_code_sign_drs.c
        load_command_encryption_info.c
        load_command_encryption_info_64.c
        load_command_function_starts.c
        load_command_id_dylib.c
        load_command_id_dylinker.c
        load_command_lazy_load_dylib.c
        load_command_linker_option.c
        load_command_load_dylib.c
        load_command_load_dylinker.c
        load_command_load_upward_dylib.c
        load_command_load_weak_dylib.c
        load_command_main.c
        load_command_note.c
        load_command_prebind_cksum.c
        load_command_reexport_dylib.c
        load_command_routines.c
        load_command_routines_64.c
        load_command_rpath.c
        load_command_segment.c
        load_command_segment_64.c
        load_command_segment_split_info.c
        load_command_source_version.c
        load_command_sub_client.c
        load_command_sub_framework.c
        load_command_sub_library.c
        load_command_symtab.c
        load_command_twolevel_hints.c
        load_command_uuid.c
        load_command_version_min_iphoneos.c
        load_command_version_min_macosx.c
        load_command_version_min_tvos.c
        load_command_version_min_watchos.c
        logging.c
        macho.c
        macho_image.c
        memory_map.c
        memory_map_self.c
        memory_map_task.c
        memory_object.c
        section.c
        segment.c
        string_table.c
        symbol.c
        symbol_table.c )

set( FQ_LIBMACHO_PUBLIC_HEADERS )
foreach( PUBLIC_HEADER ${LIBMACHO_PUBLIC_HEADERS} )
    list( APPEND FQ_LIBMACHO_PUBLIC_HEADERS ${CMAKE_CURRENT_LIST_DIR}/include/public/${PUBLIC_HEADER} )
endforeach()

set( FQ_SOURCE_FILES )
foreach( SOURCE_FILE ${SOURCE_FILES} )
    list( APPEND FQ_SOURCE_FILES ${CMAKE_CURRENT_LIST_DIR}/src/${SOURCE_FILE} )
endforeach()

add_library( macho-static
        STATIC ${FQ_LIBMACHO_PUBLIC_HEADERS} ${FQ_SOURCE_FILES} )
set_target_properties( macho-static PROPERTIES PUBLIC_HEADER "${FQ_LIBMACHO_PUBLIC_HEADERS}")
add_library( libmacho ALIAS macho-static )
set_target_properties( macho-static PROPERTIES
        OUTPUT_NAME MachO )

target_include_directories( macho-static
        PUBLIC
            $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/include/public>
        PRIVATE
            $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/include/private> )

install( TARGETS macho-static
        PUBLIC_HEADER DESTINATION include/MachO
        COMPONENT libmacho )

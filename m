Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D22632A819
	for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757689867; cv=none; b=sqDw2XJw0zSqaNmfw+iBG/SbJ8oq+TQ9q/CoJ2rp0hog+MVfpICSU6GnP/a00sZbLGBTvhZdOlzQMsDsOUczi2bLOgfrT9lm2lcB+dvtpuNHnTbQYlIHuUbHAqKdle08wAFgCakFbh1fuk3z9vMTPyUeG1BUXeaoBqYbDGkwDPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757689867; c=relaxed/simple;
	bh=olisOB+5za+t4P5vR3SQezv1tTe26b/8LyNxmfx828U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPUOJM4OA/Buq6uE5GEQ0LbyzdjyUTBBEbmQtfzh+bNw2V+Hd37Ggy7AWSw+H2kXBV95BqL9dXdbbE5cNYBvSlRwidwy6FSQlJ+ZY+BcYKBYIjJ7wNUjdxTuxSU4VzKba1gMMiEKo/s0Qy8Iek50eJz+Sq9WVJ/7hLYgOvc6RPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WubJAJkO; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WubJAJkO"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-72485e14efbso12123967b3.3
        for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 08:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757689863; x=1758294663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNgnuqtXCBxfx2G2dXAsaT/aGFlSDDhwnEcansq3QOI=;
        b=WubJAJkOJQnIMhnn6IzLIe0buPcWdYUddOlJ0l5R+p78Ifc8WWmzsO15i1RxkBwBhQ
         laZtmtcDDz0WUY+8wiov2UGfhMzKbXO8p8d346MZWentphqz1ZsQYIf72mOU5fNwZOxO
         bbk1kgDbV8O8p2gtoNwBtE7jnLpjB+FUbyo227s1MuK2cRTJqrMH/4NbfkWVGqpn/DOZ
         hr3Vid4R+QGNOhaWsc9UQs1d1rRutUuW/r+eEqEXCfufJRmuemjyIxF9Yuj9R08nV3Iw
         rduH/KgjoXP7SdYERbohUuJ6XqAW/vNJqWH5XEDBN6xBen5UNeYDHvh4nznAcpNNo5xW
         64Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757689863; x=1758294663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNgnuqtXCBxfx2G2dXAsaT/aGFlSDDhwnEcansq3QOI=;
        b=oAyaLjnU9OFgrkG3b0QOTNvg4yI10JrDOQsu+tSMFEdPmxuqkzXoz4wAetw72AxmZi
         Cx5KGT6Q1Haruhi2URCHq/oUB0iXPwaZ1QhUkbo0ozeH4zXSBTv+ERGYXmEK0ohPH2R6
         r25l7gPKMfx6Dei+ERnWEzRFRkAuS25+Qozj3xxxO6/RSHrCP3O4WEO6wKjomK35Fyfa
         97BEAgYgU/MKJ3nzfPb5X6LjjKp3f6poHfYcMmpQ7jcsjX3EtwUQIfPILOhbCTebZFoA
         Nv5AVVGM01+RQiFjJ7fdwRLkKinhFUAqG0meSfoCasXBwkkysCZj26hoacHz44KuL1Xh
         f0oQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnhJ8mc3Rxpy9e4MQwnb7UDLnVY7woVPYYqjn4OSc659tAvp075qktMcOyMAPQVcExeok74C2kJ9MEe0yr9Mg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypo8PoTgNRUwcCPMAqhZcFzSo6F9y5cUFZywlxrCFekIzVUZ7e
	Zks97DGgZyoPpTpF7Vw0zo2wqR1/YmnfWv+totJgVyvoIH9tOb+/xUVD1RzK0Kznswk=
X-Gm-Gg: ASbGncvIeXaAJMyl1PdvRfTsvmKLAMM6Zvut5gCL7KHyCmbSCCP4kBOOA+D06E6MVuo
	pMSLP1n2mRO399vrDbY4/VK3v3sDSkOMRmO3QS8BxZ4TehdcShwYeJqAzlSXwG9T8ibVdIkdUVU
	Nw69s/x+T3xQnmzWoinkeFDxZYXahZD89NZzVzi1vJf2zK3W4Sgzi4JqWEv7HHRuLy95bclPcti
	x1STRh+ON86aE7tvrkZTHGd+qED1E3PnnMWtCHzHF1lHz27yQsVyPRp8LBwEgVBFe045sAxnKGX
	iaNAqo2yajYofzJEKl32Z5pUJohLITnLC9/ADAqOMkdbF7vuwZMJRPikIvZbdoUZGaftsNoaTdH
	diGXTXSG7WKTKmIG4FCbbyVVMN1vyC3ZNvQ==
X-Google-Smtp-Source: AGHT+IEtne9c9aNxfz8OotnYXAiNsAB4JCtq87oaoJ7ML/Nd9NUoYp51pIa4pWBpc4rPSN6ehP6TAw==
X-Received: by 2002:a05:690c:9688:b0:721:1c48:a627 with SMTP id 00721157ae682-730627c990emr26695147b3.6.1757689862953;
        Fri, 12 Sep 2025 08:11:02 -0700 (PDT)
Received: from eugen-station.. ([145.224.119.89])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-624841586c1sm1302244d50.6.2025.09.12.08.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:11:02 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com,
	rdunlap@infradead.org,
	corbet@lwn.net,
	david@redhat.com,
	mhocko@suse.com
Cc: tudor.ambarus@linaro.org,
	mukesh.ojha@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	jonechou@google.com,
	rostedt@goodmis.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [RFC][PATCH v3 14/16] kernel/vmcoreinfo: Register kmemdump core image information
Date: Fri, 12 Sep 2025 18:08:53 +0300
Message-ID: <20250912150855.2901211-15-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912150855.2901211-1-eugen.hristev@linaro.org>
References: <20250912150855.2901211-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The coreimage generated by kmemdump requires some kernel information
in order to be successfully loaded by `crash` or gdb.
Register all this information through vmcoreinfo once vmcoreinfo is setup.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/vmcore_info.c | 141 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c
index 3e2e846ba9c8..1d83e95cf9be 100644
--- a/kernel/vmcore_info.c
+++ b/kernel/vmcore_info.c
@@ -15,6 +15,7 @@
 #include <linux/memblock.h>
 #include <linux/kmemleak.h>
 #include <linux/kmemdump.h>
+#include <linux/sched/stat.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -24,6 +25,17 @@
 #include "kallsyms_internal.h"
 #include "kexec_internal.h"
 
+void sched_get_runqueues_area(void **start, size_t *size);
+
+extern unsigned int nr_irqs;
+extern unsigned long tainted_mask;
+extern unsigned int nr_swapfiles;
+
+#ifdef CONFIG_IKCONFIG_PROC
+extern char kernel_config_data;
+extern char kernel_config_data_end;
+#endif
+
 /* vmcoreinfo stuff */
 unsigned char *vmcoreinfo_data;
 size_t vmcoreinfo_size;
@@ -121,8 +133,137 @@ EXPORT_SYMBOL(paddr_vmcoreinfo_note);
 
 static void vmcoreinfo_kmemdump(void)
 {
+	void *start;
+	size_t size;
+	int i;
+
 	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_VMCOREINFO,
 			     (void *)vmcoreinfo_data, vmcoreinfo_size);
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_linux_banner,
+			     (void *)&linux_banner, banner_len);
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_init_uts_ns,
+			     (void *)&init_uts_ns, sizeof(init_uts_ns));
+
+	sched_get_runqueues_area(&start, &size);
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_runqueues,
+			     (void *)start, size);
+
+#ifdef CONFIG_IKCONFIG_PROC
+	/* Register 8 bytes before and after, to catch the marker too */
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_CONFIG,
+			     (void *)&kernel_config_data - 8,
+			     &kernel_config_data_end - &kernel_config_data + 16);
+#endif
+
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE___cpu_possible_mask,
+			     (void *)&__cpu_possible_mask,
+			     sizeof(__cpu_possible_mask));
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE___cpu_active_mask,
+			     (void *)&__cpu_active_mask,
+			     sizeof(__cpu_active_mask));
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE___cpu_online_mask,
+			     (void *)&__cpu_online_mask,
+			     sizeof(__cpu_online_mask));
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE___cpu_present_mask,
+			     (void *)&__cpu_present_mask,
+			     sizeof(__cpu_present_mask));
+
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_nr_irqs,
+			     (void *)&nr_irqs, sizeof(nr_irqs));
+
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_tainted_mask,
+			     (void *)&tainted_mask, sizeof(tainted_mask));
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_taint_flags,
+			     (void *)&taint_flags, sizeof(taint_flags));
+
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_jiffies_64,
+			     (void *)&jiffies_64, sizeof(jiffies_64));
+
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_nr_threads,
+			     (void *)&nr_threads, sizeof(nr_threads));
+
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_node_states,
+			     (void *)&node_states, sizeof(node_states));
+
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_init_mm,
+			     (void *)&init_mm, sizeof(init_mm));
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_init_mm_pgd,
+			     (void *)&init_mm.pgd, sizeof(*init_mm.pgd));
+
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE__totalram_pages,
+			     (void *)&_totalram_pages, sizeof(_totalram_pages));
+
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_nr_swapfiles,
+			     (void *)&nr_swapfiles, sizeof(nr_swapfiles));
+
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE___per_cpu_offset,
+			     (void *)&__per_cpu_offset, sizeof(__per_cpu_offset));
+
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_high_memory,
+			     (void *)&high_memory, sizeof(high_memory));
+#ifdef CONFIG_NUMA
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_node_data,
+			     (void *)&node_data,
+			     MAX_NUMNODES * sizeof(struct pglist_data));
+
+	for (i = 0; i < MAX_NUMNODES; i++) {
+		if (!NODE_DATA(i))
+			continue;
+		kmemdump_register((void *)NODE_DATA(i),
+				  roundup(sizeof(pg_data_t), SMP_CACHE_BYTES));
+	}
+#endif
+
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_mem_section,
+			     (void *)&mem_section, sizeof(mem_section));
+	for (i = 0; i < NR_SECTION_ROOTS; i++) {
+		if (!mem_section[i])
+			continue;
+		kmemdump_register((void *)mem_section[i],
+				  SECTIONS_PER_ROOT * sizeof(struct mem_section));
+	}
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_MEMSECT,
+			     (void *)mem_section,
+			     sizeof(struct mem_section *) * NR_SECTION_ROOTS);
+
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_kallsyms_num_syms,
+			     (void *)&kallsyms_num_syms,
+			     sizeof(kallsyms_num_syms));
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_kallsyms_relative_base,
+			     (void *)&kallsyms_relative_base,
+			     sizeof(kallsyms_relative_base));
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_kallsyms_offsets,
+			     (void *)&kallsyms_offsets,
+			     sizeof(&kallsyms_offsets));
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_kallsyms_names,
+			     (void *)&kallsyms_names,
+			     sizeof(&kallsyms_names));
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_kallsyms_token_table,
+			     (void *)&kallsyms_token_table,
+			     sizeof(&kallsyms_token_table));
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_kallsyms_token_index,
+			     (void *)&kallsyms_token_index,
+			     sizeof(&kallsyms_token_index));
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_kallsyms_markers,
+			     (void *)&kallsyms_markers,
+			     sizeof(&kallsyms_markers));
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_kallsyms_seqs_of_names,
+			     (void *)&kallsyms_seqs_of_names,
+			     sizeof(&kallsyms_seqs_of_names));
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE__sinittext,
+			     (void *)&_sinittext, sizeof(&_sinittext));
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE__einittext,
+			     (void *)&_einittext, sizeof(&_einittext));
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE__end,
+			     (void *)&_end, sizeof(&_end));
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE__text,
+			     (void *)&_text, sizeof(&_text));
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE__stext,
+			     (void *)&_stext, sizeof(&_stext));
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE__etext,
+			     (void *)&_etext, sizeof(&_etext));
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_swapper_pg_dir,
+			     (void *)&swapper_pg_dir, sizeof(&swapper_pg_dir));
 }
 
 static int __init crash_save_vmcoreinfo_init(void)
-- 
2.43.0


Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BBB3CF1FF
	for <linux-hardening@vger.kernel.org>; Fri,  5 Jun 2026 20:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780691118; cv=none; b=WWO0fP5nXfeYihITP0smEzvnkR0BxiDuIx0OclOC2o5un23LIAesFFtt5tKwukJ8iChkwU4PCfXAOwrhU9RqyVJP/Om52AupEoRQ8HuQwslHfZjaqrpOs5mwCxzz+1/3rKTqBool6ZH5hmc5qvDbOKsCaEr42TZNJycd5S3wPyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780691118; c=relaxed/simple;
	bh=+Yjj3W9TFZsU5TJJBHdtImm5HEuPh7EsgnmvfdGSNpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6UlmUTeOaXNLNZuNtaKRRWJrV5QiQmadwZoCLAJLVV9+DvLuav0Pnt2+YW+cjvA3qkSEreI1kHjHovFEZaw1aGtxFpT7dHX0hOMjNAzmxYsmyXeQj0A+73S1NsLsrVkKr56HTZkKX9qdHgJytTyQ+moAwLiVNiUFFL7+PVjndo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com; spf=none smtp.mailfrom=yjn-systems.com; dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b=X5ZK5+nm; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b="X5ZK5+nm"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso26906345e9.3
        for <linux-hardening@vger.kernel.org>; Fri, 05 Jun 2026 13:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yjn-systems.com; s=google; t=1780691116; x=1781295916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4xcC/KZgHJbycbZQM0bK55XS+wcTEb3uOVY/3QmQJg=;
        b=X5ZK5+nm5IIFUwnXX7kIvteMS+x33jk55T5dBKup/dJ2hmaeD7oOxi7dUFAXHuNmab
         hrAo2OW0BFv+frZQJ4dtl37NWT0AhC0spxBGhmlLRz16kW4dszVM9MFOxHxtvjfXJGkC
         BKJ31JLiDnM9xBBKSuGBJRyVt/oHZ4IcxRrYmSnouhpArVuL+90pi6Vs5mK8Y2PfwCdC
         CTbp4jM3Ugo+DkMob9CqGTwErSFcn2YneQEggVNswjw717iZs+61tBHQdq4oknLjB36c
         F+7JfE2d815noAfQY8oKE5bhuwoeauotkvhUsYj5I+SltV80LEJNLS9KcGuA/ny3z46c
         /aXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780691116; x=1781295916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q4xcC/KZgHJbycbZQM0bK55XS+wcTEb3uOVY/3QmQJg=;
        b=ZD4nkaCUilEhoODxwP9b0L27ANX6DrFl8u3ixCyiIo/4zhrkddVRnsK0kx1l+0mqEE
         xpQ3SqtND4PjVTRY9pi88VPUsA4gHj4SVK3wwFuWaUstD6nLH/HgcSbBVatz32KTzzJZ
         Qz+skekGXsXL/L9CEzIxWi+tmFOLn+hnHRIDeBya/DuTub+/yMbVjQ+pwEOLxML4L6zH
         q2YsuFLV1sb/6992x0El+EZRZc+8D3MojxOzeL3jUFccENL2/ywQof/Z1S5riLXSQOZ5
         HR7SrGpjdKITzIUjv77oxMLRg8+fuDpEQ8Oozx+nnMI7nd3fi4ke6Wupvl1z8q6WLURU
         uFfQ==
X-Gm-Message-State: AOJu0Yxv4MckCL2AupudNVvEZcQk1/rNm+vj8uyci1kqCFBV1eVkgjvL
	OxaklbPkuaGiMFYoXkP7lADq2Nca/gtIoWXg6KtS3lmdVolCR2YhkCt/KrAdwAtCD96tZHEdKwB
	5OCsxofL8
X-Gm-Gg: Acq92OFWuzCWlOZvjODVZCBw+M7glwoJH2Fw2W5+slHz5j0USaDfbhV9Desyat7PsoH
	79eUBX2f6cheaaPo24Le81Cds41KOOyaqsMdwn7HnszRS8mZwaQ/c+/s1PjCSTuJGoAG4LORIhO
	iUGTjWt7RUyubrxNhU8xNeJqemjEvgRfi0gPgDEcIRc9FyU4VM7qPrV04/ffrFTwsJMMCVFTiIB
	4P38/RW/7m5BDicN/ngW6kHWT19ZXA+iiRgPO8kyK14HrKvHfiX1ZUYxahoihMqF0RrJmKM/0Oo
	OqvKfcJjCFe1nRY3MKgv8By423/gVKK9FX9VmD4Q0mbN5jNDMguHwmIDhveMhL6ld+XuW9fKILg
	UPe8RZJYlaRNx5d9Cmzy1N/vZEBOOjadntfsvvC09JRJ1DVwKq7i8JAqe2m+fQ4Gs2sfofuxNIb
	MtjQQAu4EDBNyRqqysEANElNJFFLPg+Or9wZOdSsGkLvpIycHUzjZbFCajSwDDekR158nTSqMMm
	XIUy/KILJpvgygjReR6f63hGeCmQJU+BYe9KiMQqyYoJiwMjg==
X-Received: by 2002:a05:600c:314b:b0:490:548e:b854 with SMTP id 5b1f17b1804b1-490c25f5e25mr84723905e9.26.1780691115710;
        Fri, 05 Jun 2026 13:25:15 -0700 (PDT)
Received: from yjn-Zenbook-UX3404VA-UX3404VA.. (p200300dcbf13e6006c589ea22c400ee8.dip0.t-ipconnect.de. [2003:dc:bf13:e600:6c58:9ea2:2c40:ee8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3a87dasm168442995e9.7.2026.06.05.13.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 13:25:15 -0700 (PDT)
From: York Jasper Niebuhr <yjn@yjn-systems.com>
To: linux-hardening@vger.kernel.org
Cc: kees@kernel.org,
	franzen@sec.in.tum.de
Subject: [RFC 3/7] SPSLR tool build integration
Date: Fri,  5 Jun 2026 22:25:07 +0200
Message-ID: <20260605202511.79272-4-yjn@yjn-systems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605202511.79272-1-yjn@yjn-systems.com>
References: <20260605202511.79272-1-yjn@yjn-systems.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: York Jasper Niebuhr <yjn@yjn-systems.com>
---
 tools/Makefile       | 15 +++++++--
 tools/spslr/Makefile | 78 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+), 2 deletions(-)
 create mode 100644 tools/spslr/Makefile

diff --git a/tools/Makefile b/tools/Makefile
index 278d24723b74..55e393a0a63d 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -42,6 +42,7 @@ help:
 	@echo '  mm                     - misc mm tools'
 	@echo '  wmi			- WMI interface examples'
 	@echo '  x86_energy_perf_policy - Intel energy policy tool'
+	@echo '  spslr                  - Selfpatch-SLR build tools'
 	@echo ''
 	@echo 'You can do:'
 	@echo ' $$ make -C tools/ <tool>_install'
@@ -119,11 +120,18 @@ freefall: FORCE
 kvm_stat: FORCE
 	$(call descend,kvm/$@)
 
+spslr: FORCE
+	$(call descend,spslr,)
+
+spslr/%: FORCE
+	$(call descend,spslr,$*)
+
 all: acpi counter cpupower gpio hv firewire \
 		perf selftests bootconfig spi turbostat usb \
 		virtio mm bpf x86_energy_perf_policy \
 		tmon freefall iio objtool kvm_stat wmi \
-		pci debugging tracing thermal thermometer thermal-engine
+		pci debugging tracing thermal thermometer thermal-engine \
+		spslr
 
 acpi_install:
 	$(call descend,power/$(@:_install=),install)
@@ -215,12 +223,15 @@ freefall_clean:
 build_clean:
 	$(call descend,build,clean)
 
+spslr_clean:
+	$(call descend,spslr,clean)
+
 clean: acpi_clean counter_clean cpupower_clean hv_clean firewire_clean \
 		perf_clean selftests_clean turbostat_clean bootconfig_clean spi_clean usb_clean virtio_clean \
 		mm_clean bpf_clean iio_clean x86_energy_perf_policy_clean tmon_clean \
 		freefall_clean build_clean libbpf_clean libsubcmd_clean \
 		gpio_clean objtool_clean leds_clean wmi_clean pci_clean firmware_clean debugging_clean \
 		intel-speed-select_clean tracing_clean thermal_clean thermometer_clean thermal-engine_clean \
-		sched_ext_clean
+		sched_ext_clean spslr_clean
 
 .PHONY: FORCE
diff --git a/tools/spslr/Makefile b/tools/spslr/Makefile
new file mode 100644
index 000000000000..400b86edf5ec
--- /dev/null
+++ b/tools/spslr/Makefile
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: GPL-2.0
+
+CC ?= gcc
+
+# If CXX was not passed, derive it from CC.
+ifeq ($(origin CXX),default)
+override CXX := $(subst gcc,g++,$(CC))
+endif
+
+OUTPUT ?= .
+
+PINPOINT := $(OUTPUT)/pinpoint.so
+PATCHCOMPILE := $(OUTPUT)/patchcompile
+
+GCC_PLUGIN_DIR := $(shell $(CXX) -print-file-name=plugin)
+
+COMMON_CXXFLAGS := -std=c++20
+
+PINPOINT_CXXFLAGS := \
+	$(COMMON_CXXFLAGS) \
+	-fPIC -fno-rtti -fno-exceptions \
+	-D_GNU_SOURCE \
+	-Isrc/pinpoint \
+	-Isrc/pinpoint/safegcc \
+	-Isrc/pinpoint/stage0 \
+	-Isrc/pinpoint/stage1 \
+	-Isrc/pinpoint/stage2 \
+	-Isrc/pinpoint/final \
+	-I$(GCC_PLUGIN_DIR)/include
+
+PATCHCOMPILE_CXXFLAGS := \
+	$(COMMON_CXXFLAGS) \
+	-Isrc/patchcompile
+
+PINPOINT_SRCS := \
+	src/pinpoint/pinpoint.cpp \
+	src/pinpoint/stage0/on_register_attributes.cpp \
+	src/pinpoint/stage0/on_finish_type.cpp \
+	src/pinpoint/stage0/on_preserve_component_ref.cpp \
+	src/pinpoint/stage0/on_finish_decl.cpp \
+	src/pinpoint/stage0/on_start_unit.cpp \
+	src/pinpoint/stage0/target.cpp \
+	src/pinpoint/stage0/separator.cpp \
+	src/pinpoint/stage0/separate_offset_pass.cpp \
+	src/pinpoint/stage1/asm_offset_pass.cpp \
+	src/pinpoint/stage2/rtl_pin_lower_pass.cpp \
+	src/pinpoint/final/on_finish_unit.cpp
+
+PATCHCOMPILE_SRCS := \
+	src/patchcompile/patchcompile.cpp \
+	src/patchcompile/accumulation.cpp \
+	src/patchcompile/emit.cpp
+
+PINPOINT_OBJS := $(PINPOINT_SRCS:.cpp=.o)
+PATCHCOMPILE_OBJS := $(PATCHCOMPILE_SRCS:.cpp=.o)
+
+.PHONY: all clean
+all: $(PINPOINT) $(PATCHCOMPILE)
+
+$(PINPOINT): $(PINPOINT_OBJS)
+	$(CXX) -shared -o $@ $^
+
+$(PATCHCOMPILE): $(PATCHCOMPILE_OBJS)
+	$(CXX) -o $@ $^
+
+src/pinpoint/%.o: src/pinpoint/%.cpp
+	$(CXX) $(PINPOINT_CXXFLAGS) -c -o $@ $<
+
+src/patchcompile/%.o: src/patchcompile/%.cpp
+	$(CXX) $(PATCHCOMPILE_CXXFLAGS) -c -o $@ $<
+
+.PHONY: clean
+
+clean:
+	@echo '  CLEAN   tools/spslr'
+	@rm -f ./pinpoint.so ./patchcompile \
+		$(PINPOINT_OBJS) \
+		$(PATCHCOMPILE_OBJS)
-- 
2.43.0


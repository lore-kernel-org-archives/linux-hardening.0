Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D901831AF0E
	for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757689819; cv=none; b=i2ENfDCUL6nBZGPv6gGwUAuCHJGGOzTYYmE4L5CXaDtpWW5uZrx9AKdkPOhd94NEQfo42KRKJCAibe28VVo+vziWyjqGO+v3Bp0LdV2Ivog6dAev69JPVuvLznolMtfpFCSh/pWBanUbX4VLgBA8qubGljq3dj6/aB8ARE7UzqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757689819; c=relaxed/simple;
	bh=UuHbFeGDi3ya4Y1827EkloRKbNopIVD89d4PRR3A4tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WBZtryKlNHVCzvTpgzbimyp6PiZA7wolI4z5QKo3EfMViVSwIdxwYetNIrpoftFJsB24DS24RDMcjqzmnfqRHQ0CzzKUCRFQvWl6z3Bi+UTwRqEvQOiOm+Svo0T2UJel8RZd0s10frB1ltV1xso2Xntg+aiGfWTOXj399ttdX0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jBAcm+Pd; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jBAcm+Pd"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-72267c05111so15215117b3.2
        for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 08:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757689816; x=1758294616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYcAOyUQwZgCVnm8L3SgUsalr9j/YAFyY5/IbjQaIJs=;
        b=jBAcm+PddBb8sMhrZ7dAuPKs4de9nquuujJRewZUZU/6mED43rKbRAaQMk3SwDlKJg
         u3n14KmEoOUJtbbOWAnexNdmV/pjdk2xBoeoYYZrRpsWdy6avezovqoNwMb6P4Rbpqkd
         wo+EbSJVEnvUGUFaY8C4soguYtGMuwhmy/wI/WjCTx4sgfKS5M0r+N/IScUh9mwVQ4lc
         d0fj847sKqSwLrBQinCWG529JX2usHBINq66OhvFfCXLf3DFJ8Qq3xaJXVx1mQM+bdZ+
         Pw4TsAF0Hq1ZNIR1cckL6kL/ExXc3Ufiv7rsFgz+rniq9JnfEQBhYKzSFCm7JJV0/JNh
         Q8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757689816; x=1758294616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYcAOyUQwZgCVnm8L3SgUsalr9j/YAFyY5/IbjQaIJs=;
        b=W8fBvsCdBBu4N/EBl0XV6R6BL6hfLpExWF2KEOc18tl9hcn+wE0BEHRFsdhcUqFtQ8
         mXYLe6G//a2z5/qkgpU4dDtGpsbr5s4CzflA02yoGbxgEwu6Ilh7oGED2hDumionUP2W
         pzajhDraRAAxW+6n1/D4eHhddo2D1/eMHIGmCgVPdGrRhlvk7ftfHn+eDftMIiF0RbdN
         8Z3JYXLVR76nvIGz9XZQWfiUbFDDAept2iXxLZ967kxeDOqsmvTZPCcvFgGHgqZItI53
         UIxlnfy4dJO2J1cutgHDNVt6yMluqHktAfMCkIavvFnZiCLTptfpSM5f3m7Q0+oCEH3T
         WI3A==
X-Forwarded-Encrypted: i=1; AJvYcCVMvqflfrCnEgbvhZ6F8CIR3/4Hu2EQBRPGO8jvad56RlWh56XmV6aA869h2gfUas4KCGal0TJ9AI0tddfZ0jg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw688Wh/iT5EYyfl+tDp9h9L60cgSvCo1fxGk7cveItmu+sRTSh
	LojtrIHBKz2wEQmFF3ZV/rWF1Vlfvb/uW7EQWonrYPFz+oCJZp7i5V/Q1wfbFV4JEPI=
X-Gm-Gg: ASbGncuEcZDcdE9TkX4cnVfeTT9TrWexf4AsAGRqTRnZz8whDk0aapgJyvLJtT/MURx
	fQP9TMbso/+w+24oqvmotPCoU3GWdF092m0p6EjT5sE+i5LZYhz7CEFlXx4JQLUDkZtxpoftuAs
	YeS6W7ZXbIOcAEdj3bZCs/sg1XVPvLEDABWH1Qze8KCgdBylYKIw61mF+HxuBmFQ0xcuQfTHFiB
	CziZJ6jqnZXwhTrfEgXGdk1zdxjR9QcAwjLEdHYF2AS0PVSMBbGRWIJAVeRNn0YpUcX5aq2hjp6
	b1+P0TjcuXEJ+Tok3VvPOuhTs2/kzlI0gO0Xm5iuaBzbzVm0CSys2yMxHNl2OvyLiP2AcjbvXR9
	SgXEeIKHMBFZmFJti1C1q8LIw3jM4hxZ+KAWdWnObDoR8
X-Google-Smtp-Source: AGHT+IHdun55kCQevX+5NMIZ7KQNmYxmG9E8Uto+0Ih94+Wvd6F4Zhy4kkyG4jBHuGQaEGCxBRlhMQ==
X-Received: by 2002:a05:690c:4d8a:b0:723:8943:d6d3 with SMTP id 00721157ae682-73062ab4292mr27250037b3.6.1757689815690;
        Fri, 12 Sep 2025 08:10:15 -0700 (PDT)
Received: from eugen-station.. ([145.224.119.89])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-624841586c1sm1302244d50.6.2025.09.12.08.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:10:15 -0700 (PDT)
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
Subject: [RFC][PATCH v3 05/16] kernel/vmcore_info: Register dynamic information into Kmemdump
Date: Fri, 12 Sep 2025 18:08:44 +0300
Message-ID: <20250912150855.2901211-6-eugen.hristev@linaro.org>
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

Register vmcoreinfo information into kmemdump.
Because the size of the info is computed after all entries are being
added, there is no point in registering the whole page, rather, call
the kmemdump registration once everything is in place with the right size.
A second reason is that the vmcoreinfo is added as a region inside
the ELF coreimage note, there is no point in having blank space at the end.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/vmcore_info.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c
index e066d31d08f8..3e2e846ba9c8 100644
--- a/kernel/vmcore_info.c
+++ b/kernel/vmcore_info.c
@@ -14,6 +14,7 @@
 #include <linux/cpuhotplug.h>
 #include <linux/memblock.h>
 #include <linux/kmemleak.h>
+#include <linux/kmemdump.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -118,6 +119,12 @@ phys_addr_t __weak paddr_vmcoreinfo_note(void)
 }
 EXPORT_SYMBOL(paddr_vmcoreinfo_note);
 
+static void vmcoreinfo_kmemdump(void)
+{
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_VMCOREINFO,
+			     (void *)vmcoreinfo_data, vmcoreinfo_size);
+}
+
 static int __init crash_save_vmcoreinfo_init(void)
 {
 	vmcoreinfo_data = (unsigned char *)get_zeroed_page(GFP_KERNEL);
@@ -227,6 +234,7 @@ static int __init crash_save_vmcoreinfo_init(void)
 	arch_crash_save_vmcoreinfo();
 	update_vmcoreinfo_note();
 
+	vmcoreinfo_kmemdump();
 	return 0;
 }
 
-- 
2.43.0


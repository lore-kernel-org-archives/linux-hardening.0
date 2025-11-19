Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB6A377EB1
	for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 15:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567161; cv=none; b=fPhJiT7WjIfxJdo+7BYFKAWt/CBbYxzvRzeWD8o9zbM16d2Zbs/DzKpHSeyDMOFwWTjY753zPfSfyh0FcBrephZkqC7tozcrbKb0WU0XJLUhkO1v483lzLsoF+cvvL4Hkpr+5bw1utSejt7u6W/qP3nP33ecg3+mEohg1puz5as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567161; c=relaxed/simple;
	bh=seLIx9q9vL0GJtrOwhh44Y8oeZ01I2U3Qbuzz6J6f2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GIEN11GeZztowIM23YUrWxHgRCkyw79zWPkkhWtOo0BDuUdQd6Oz0+CAvxAF/n/Fulj1RgCkg4msmi2yLC5bYPv6Z97UvdeHh39bFp3GypKEzoQJP/8aUEU7MXZ2EADZfbX5XrI8ZoHw3qZfsqdYushiBjniRP3ErKA2ei1WSv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OlsKOf7C; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OlsKOf7C"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b32a5494dso4139079f8f.2
        for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 07:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763567153; x=1764171953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7Ucs3kp0oXjJAHNPlew8LSoAGCaHnYy/9pb2BVOQfw=;
        b=OlsKOf7CJM2UCkg8sSzf3D6dnC50mCYotNLiG83mI1qis2cSNEl6iYyMVoNUiPWFtn
         q+XeohqZ2L4g2rfVHlxX/Z74xnezMqq6Q2RDI7kKiJAAVdhgk1bmjDpTEad7w+oD+d5r
         XhwrehKHLA8zA/6PTLm1D8myUX20MDo61BthVNchOC3ajJi+FtetAbFElpDNH0txiQfl
         YkpKzG5UU3whCwYwxvP6bNGvK5NjG96/oE4wLDMc20Z9xA4rAsIdLgPvh/YVk9Ey+l4D
         ICFEIP6vLzLnMBBLHX1AFbnh29b1KM9hSgdIu/yPFwLWWVFyENhMFbVyN3hTLNk7gE9T
         2itQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567153; x=1764171953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y7Ucs3kp0oXjJAHNPlew8LSoAGCaHnYy/9pb2BVOQfw=;
        b=UdgsOX+arWmOyhOTb4Q5BLVP/wV36euOW2QcM8vTW9I9c+XbhEJaCaBIGkGQZS5Qgt
         EA6itFxCkFKGUxaThlYMPjEJcPmPRCUtMx0Et4gOi1rs016Jtp+nF39d/m6pINvOZGhr
         iccfxbcQ4dw0No3uQ1Ot5AIfeAl89X0aCkTn26heW2gBt1ttWtrNPyc2UL85qXpQUAQt
         X6w/XQoDs6vzon91pyMV3EgPTymWWR5dx9GOmbhSraOXdp0sYt4tkjCpnA+fC3Cu7cd0
         n7pGK9XibVkpZHH83SXIyIvqqWsdQI96ozn9HU+jzzMP2Ufqw54eyGnhu0srxi2+z+kD
         jMhA==
X-Forwarded-Encrypted: i=1; AJvYcCXDN38Zr04QEmLgHtLWUuc8NrFiJJOtBxbprE3j/RdXXQBXZX6RyQtvtnNUKQf74WH2i2gAnZnZUAI1yPypD+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAZ69Ecet5JwVx8OU7BNL9Wtg96FPAW5fr0Qqf6+7NmfJSpMxX
	N2Do/8ItH9TiV2g8npXpxYaY5bLicJ7AoGFnuG4kcmPDKBngMQZne59gUz1rTk3mIa0=
X-Gm-Gg: ASbGncsPKzwysbHWvE05ngD5VEVjYJBQiwiAMaDiUFzGDd0wJGwdMHX1ganYDATJViE
	ecux0ZU6TqYfGwuukD2nGJad2O/9JY9jepHn6rlQYuev1chb84jcs2qcGQTiTvTp+/gXmz4jbuD
	O59khcRf9vkhiRM0nVpLEkIYlxqqF4pGoyjEN2mEOVDU4o/gssG+XOy0q7YfwAktGL45HSYiQ24
	mg+YFqdcf01CCoONJbu+v8oZbpDeZyIOSia6eYFs7MrvNldbLVGM64QXnZH9jTpvH+xQRS5lcqP
	ato7FtZ+mQGCswM9OUdj0APIhaHcmgmUQ2kfrP4B2jazoGgTJ6eDC7M9c/q0AJqZIWL8QvBRiY4
	WQNzA1hw1SYiF5+6CLacVMRwxX8fHCr/KAqWd0HIOLzeeeB+WRrLtEwZPIZhNhQY0UlxnPwj12D
	WUtGlnQ0javM4yORywthoc0muCBCAzmw==
X-Google-Smtp-Source: AGHT+IFMxVwxw3DtlUhFwveVzixkh9p9iHWd+faYE31GhqiINsGSMiGzAK7z2FWSCj0eS8F6/aaKoQ==
X-Received: by 2002:a05:6000:2510:b0:42b:3e20:f1b4 with SMTP id ffacd0b85a97d-42cb1f1de66mr3206403f8f.5.1763567153508;
        Wed, 19 Nov 2025 07:45:53 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53dea1c9sm38765632f8f.0.2025.11.19.07.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:45:53 -0800 (PST)
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
	linux-remoteproc@vger.kernel.org,
	linux-arch@vger.kernel.org,
	tony.luck@intel.com,
	kees@kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH 21/26] printk: Register information into meminspect
Date: Wed, 19 Nov 2025 17:44:22 +0200
Message-ID: <20251119154427.1033475-22-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251119154427.1033475-1-eugen.hristev@linaro.org>
References: <20251119154427.1033475-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate vital static information into meminspect:
 - prb_descs
 - prb_infos
 - prb
 - prb_data
 - printk_rb_static
 - printk_rb_dynamic

Information on these variables is stored into inspection table.

Register dynamic information into meminspect:
 - new_descs
 - new_infos
 - new_log_buf
This information is being allocated as a memblock, so call
memblock_mark_inspect to mark the block accordingly.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/printk/printk.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 5aee9ffb16b9..8b5aba2527ac 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -49,6 +49,7 @@
 #include <linux/sched/debug.h>
 #include <linux/sched/task_stack.h>
 #include <linux/panic.h>
+#include <linux/meminspect.h>
 
 #include <linux/uaccess.h>
 #include <asm/sections.h>
@@ -513,10 +514,16 @@ static u32 log_buf_len = __LOG_BUF_LEN;
 #endif
 _DEFINE_PRINTKRB(printk_rb_static, CONFIG_LOG_BUF_SHIFT - PRB_AVGBITS,
 		 PRB_AVGBITS, &__log_buf[0]);
+MEMINSPECT_NAMED_ENTRY(prb_descs, _printk_rb_static_descs);
+MEMINSPECT_NAMED_ENTRY(prb_infos, _printk_rb_static_infos);
+MEMINSPECT_NAMED_ENTRY(prb_data, __log_buf);
+MEMINSPECT_SIMPLE_ENTRY(printk_rb_static);
 
 static struct printk_ringbuffer printk_rb_dynamic;
+MEMINSPECT_SIMPLE_ENTRY(printk_rb_dynamic);
 
 struct printk_ringbuffer *prb = &printk_rb_static;
+MEMINSPECT_SIMPLE_ENTRY(prb);
 
 /*
  * We cannot access per-CPU data (e.g. per-CPU flush irq_work) before
@@ -1190,6 +1197,7 @@ void __init setup_log_buf(int early)
 		       new_log_buf_len);
 		goto out;
 	}
+	memblock_mark_inspect(virt_to_phys(new_log_buf), new_log_buf_len);
 
 	new_descs_size = new_descs_count * sizeof(struct prb_desc);
 	new_descs = memblock_alloc(new_descs_size, LOG_ALIGN);
@@ -1198,6 +1206,7 @@ void __init setup_log_buf(int early)
 		       new_descs_size);
 		goto err_free_log_buf;
 	}
+	memblock_mark_inspect(virt_to_phys(new_descs), new_descs_size);
 
 	new_infos_size = new_descs_count * sizeof(struct printk_info);
 	new_infos = memblock_alloc(new_infos_size, LOG_ALIGN);
@@ -1206,6 +1215,7 @@ void __init setup_log_buf(int early)
 		       new_infos_size);
 		goto err_free_descs;
 	}
+	memblock_mark_inspect(virt_to_phys(new_infos), new_infos_size);
 
 	prb_rec_init_rd(&r, &info, &setup_text_buf[0], sizeof(setup_text_buf));
 
@@ -1258,8 +1268,10 @@ void __init setup_log_buf(int early)
 
 err_free_descs:
 	memblock_free(new_descs, new_descs_size);
+	memblock_clear_inspect(virt_to_phys(new_descs), new_descs_size);
 err_free_log_buf:
 	memblock_free(new_log_buf, new_log_buf_len);
+	memblock_clear_inspect(virt_to_phys(new_log_buf), new_log_buf_len);
 out:
 	print_log_buf_usage_stats();
 }
-- 
2.43.0


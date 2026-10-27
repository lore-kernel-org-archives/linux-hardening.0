Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793086576;
	b=HHYlr7jnFit0vY8WtFe59mhxCc872uUwYqQ52qIuZL4b/UWQvpAemWza8q/85cHDstiZ
	 JnWUaS0fekKRhwZ1j0TC+KHdh8S91+NTL1y1NFplN6ues4p58whZjTErDtyXaY8EHf3u1
	 vxqAzYIoJ49XFk5B+HTTY6xh05o50NDE7vnXMW5OotkMHS+GueZqcYtVA9p2R5Uxt7kbp
	 YT74+qP4YDPpjTs6IssofLfVmfJov0hTt6Z4N+mAniB3NFu7mH73g3uAGTjGFPbtFOsn9
	 DQr3DILeJjDOco3QM186Ly3F9XYfndzcBi3lOpvdacuC3iBrCxZC4LLuLUSmb/RlTRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793086576;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=dOacexIKHraWCg9yl1hlssxWGivRL2xIzkUcida+0nw=;
	b=00u1q6ECq1STAhgVqoB+NVKE+0twwilgWNAD2874KQLAk36ZrpYMQ8v96GPq2TCgnrtB
	 K+OgmCwLakelyzMv9D22HQb6Iy2tVuV363SThWeHWqGsf6ujwJ6uNd/BNJXNm4rhtsno/
	 6AZauiiSZbaoKmp2OD+s4yF2L63qTYPulnaIfvBclSl2ONoFm9xGXtnw4BfgOb0fPLGHf
	 +9KXzBrfk7FKNoWAWKQMIji0WzDf1Z8iVsZlVP8IRTQlYPj8whEixrlS0W6C65PWjOOzN
	 v6Sizkfk2bX4SluZwGO7IAACqUBNc6kb0RG+MD3YMKikUU0Tnn/RIJjghXDGRcDY1GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=M79mcIHG;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F019F606A332
	for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 07:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F019F606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=M79mcIHG
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ac7842c17dso2166292a91.3
        for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 00:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793086575; x=1793691375; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=dOacexIKHraWCg9yl1hlssxWGivRL2xIzkUcida+0nw=;
        b=M79mcIHGuHPL1m6cfk9iKqAoGpVCK2z7DNCA0lY6hiO5ngsUUYaEIXNrDLp6x5FtEy
         57XZ6PyeZmYRslT6UnKALitb4LNl0rsd1LJKUUQ/udMuod62deAlUV3wjhvQjRuyeYbK
         YuS1bUTyJeVf/gn28Nc6gDACb0NVuZ9RcHsYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793086575; x=1793691375;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dOacexIKHraWCg9yl1hlssxWGivRL2xIzkUcida+0nw=;
        b=a9b155fcCzFhN31sWkAGCd0sh8ZjEaVbNvvB7Ae5cSElkQBwz0tDCFuOpirCzytDZW
         D5AqvClsHRRtxiAHUoo51Q6cr8ozbC9lKelodQxszdNC1BXKyt2uZk/lGnUfGbJY2wzj
         e2XN0UNDv15G7KBVnfzi5UlarHI+5u02dsk3a3VSbL/VSMsidkJ3pxFGxU5/zI+l8lzl
         NehtfVGaAj6p2oSLflLgkFwXfcx3VRlJ2lbRtgd7giuaJ5/khEoQ7az6vXpNUImAyPws
         LBrQ0ZkzgE6h+cZLGqzOxEw3ElEAENhoUW/CZiLEqcpC8ei3T/vBecs2wbnmDnn56WVZ
         blKg==
X-Forwarded-Encrypted: i=1; AKwUvBwTfpWm9G918epXI0XbnmD1CgzKUN0mXaNl+zl3F+Q15cezpd+IshT5FWUF1JlK7Kid3pI7IIQxN2479X3S0C8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLLCsvSe1jAHjbBwZka7N6JCVo1qD1ZPZ4O+UamCEFTXnQIJ/72
	lPldgTcN+mUoTpzy8to2dbajJ2+RjdljnYHyMMcxXDkhFjCzJQnEdZ/sJNDutdiseIY=
X-Gm-Gg: AYBFou1n423B7HWZAx+2cJqMa4coYhtY68VhoBkS5SDXVyR6bjHcYMkXkwl3+IBxrtt
	SlISTg98YP/GKRdiP++Q+d/osOsj8W+JPZFPa65a7Rwls9rENNuzLQ+ou+ieJgnx6nfBS2CrhfU
	q3tiyjWMkZ04sDrRED9yNyBlmrQBUzOEFReqzdUOqew68TZ2XyhNDSTmP8dW0ONfqzMfcS2tJgk
	4dvNcxnLuZAS4b/vAdrXMC56jEcp+GLndAUDzfr9ZVfEhnfHzy05Sv6Fgi9Hi4L6aOrHvyO/Pl/
	q9zBM373QhRE5OGSiJSUhAbrFwutcZqkJwgCjqTUMi8tcfuK/jnAsR/vDOtCRh9X7bnCGJpYOld
	3QemopPkj1SexBOXhi1/kh9bySSrfozLwMilk6ILm5bOtbd8LqYdHkHpe4rHlsZ3MPIBUWkHR6D
	ZhgiY6/BWh9ec/4v2iSX1RkWM7F5cSMoDnrATJaF2R6WAiBEQFaqyr8WLYg4fnfHO1pmlnD/PLy
	BS3tu0sxEOnjeUFyuvNrD3GwU1yISUowJLxLTrSRJQ+hsq849RrZ80T4trePwkHI3YPwT9ZsLt5
	KhalrdaUIlRrRI4mmTYbDy0YKaJZ4nHuLE0lh+Apo9N59Wj8IrsyI5vS44TTqFKEMV6TO0kQB7+
	ESLkIlTnjBZK0q7Qp+gGrZlw=
X-Received: by 2002:a17:90b:48cb:b0:3ab:1b19:78ed with SMTP id 98e67ed59e1d1-3adea9dca32mr7453567a91.21.1793086575392;
        Tue, 27 Oct 2026 00:36:15 -0700 (PDT)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae40472ed9sm2570983a91.16.2026.10.27.00.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 00:36:14 -0700 (PDT)
Date: Tue, 27 Oct 2026 15:36:10 +0800
From: Chris Down <chris@chrisdown.name>
To: Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Kees Cook <kees@kernel.org>, Marco Elver <elver@google.com>,
	GONG Ruiqi <gongruiqi@huaweicloud.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH 7/8] mm/slab: Support disabling KMALLOC_PARTITION_CACHES at
 boot
Message-ID: <1b07254587060aea4bb296ceb10f80e09b46e95a.1793086056.git.chris@chrisdown.name>
References: <cover.1793086056.git.chris@chrisdown.name>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793086056.git.chris@chrisdown.name>
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)

Add a kmalloc_partition= early parameter, enabled by default on kernels
built with CONFIG_KMALLOC_PARTITION_CACHES=y.

Let's leave kmalloc_type() unchanged since each index simply resolves to
the same cache when partitioning is off.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 .../admin-guide/kernel-parameters.txt         |  7 +++++++
 mm/Kconfig                                    |  5 +++++
 mm/slab_common.c                              | 19 ++++++++++++++++++-
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 20710d6ccd1f..9752bd2aaa72 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3054,6 +3054,13 @@ Kernel parameters
 			Configure the RouterBoard 532 series on-chip
 			Ethernet adapter MAC address.
 
+	kmalloc_partition= [MM,EARLY]
+			Format: <bool>
+			Enable or disable kmalloc cache partitioning on
+			kernels built with CONFIG_KMALLOC_PARTITION_CACHES=y.
+			Ignored without that option.
+			Default: on.
+
 	kmemleak=	[KNL,EARLY] Boot-time kmemleak enable/disable
 			Valid arguments: on, off
 			Default: on
diff --git a/mm/Kconfig b/mm/Kconfig
index ebdf14a87c71..12fbd7075705 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -270,6 +270,11 @@ config KMALLOC_PARTITION_CACHES
 	  limited degree of memory and CPU overhead that relates to hardware
 	  and system workload.
 
+	  The partitioning can be disabled at boot with the
+	  "kmalloc_partition=0" kernel parameter, in which case the copies
+	  are not created and all normal kmalloc allocations use the
+	  regular kmalloc caches.
+
 choice
 	prompt "Partitioned slab cache mode"
 	depends on KMALLOC_PARTITION_CACHES
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 9fe48da12010..5391149a2eed 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -781,6 +781,16 @@ unsigned long random_kmalloc_seed __ro_after_init;
 EXPORT_SYMBOL(random_kmalloc_seed);
 #endif
 
+#ifdef CONFIG_KMALLOC_PARTITION_CACHES
+static bool kmalloc_partition_enabled __ro_after_init = true;
+
+static int __init setup_kmalloc_partition(char *str)
+{
+	return kstrtobool(str, &kmalloc_partition_enabled);
+}
+early_param("kmalloc_partition", setup_kmalloc_partition);
+#endif
+
 /*
  * Conversion table for small slabs sizes / 8 to the index in the
  * kmalloc array. This is necessary for slabs < 192 since we have non power
@@ -1013,8 +1023,15 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type)
 	}
 
 #ifdef CONFIG_KMALLOC_PARTITION_CACHES
-	if (type >= KMALLOC_PARTITION_START && type <= KMALLOC_PARTITION_END)
+	if (!kmalloc_partition_enabled) {
+		/* Use the normal caches, which have already been created. */
+		if (type > KMALLOC_PARTITION_START && type <= KMALLOC_PARTITION_END) {
+			kmalloc_caches[type][idx] = kmalloc_caches[KMALLOC_NORMAL][idx];
+			return;
+		}
+	} else if (type >= KMALLOC_PARTITION_START && type <= KMALLOC_PARTITION_END) {
 		flags |= SLAB_NO_MERGE;
+	}
 #endif
 
 	/*
-- 
2.54.0


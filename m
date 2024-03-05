Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D981154F8E
	for <linux-hardening@vger.kernel.org>; Tue,  5 Mar 2024 10:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709633433; cv=none; b=Bt8NuoZ0uLR9Ji9sk6E739fDDRQ6aHnS/lYP6jXshRAS4c2u+uykIeavF/b/cXHDOLIEDE2Yp6BlGViSGJYztzVeosgSFyRI9Orz0Xwe+hfyoX15xQwvhDCkX4iLQelCyHy7J9Zz6DdJXJmTbZgDVG8EVnS+Lhiv0dwjQKX81Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709633433; c=relaxed/simple;
	bh=k3ROePG0wD7icc8xiWOerLraaHU6zkW2VMYF75ammOw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MOGJu2dnX0u2W1yzKkDze0Y1Fjx1+FTTPe36bgwWTH5Mn+isWKymaubEszxW1sMo7BTYXNsCMFwJUlKXCuRN+/8WidSLOTjrOzl+nEQV92aFOQ+4eZ/mtJY137643BjvI+0xsRZxollz2xH29YbHoJBjr6/EQrQ3XeGbH00BEFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oduSlXmU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oduSlXmU"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dba177c596so34016515ad.0
        for <linux-hardening@vger.kernel.org>; Tue, 05 Mar 2024 02:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709633431; x=1710238231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4oJMKLdbK31ulnxzAH51pNhqUof8xsZThnS45kbbx0=;
        b=oduSlXmUp03ACFepizrKbxgClSFCuTX3N+CRwNCngRnKw41jIiGqGjWav9PPs9KZYZ
         mNUmT0Q3222qygl56XeEDfMDVm8XsWYRFS4+oH2OhtoOd4/gMNL5DIK74vBvQ7l0/x0o
         g3q7cPDRbRp6KD7o5BUGTv/LpqjjClHFVwPNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709633431; x=1710238231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J4oJMKLdbK31ulnxzAH51pNhqUof8xsZThnS45kbbx0=;
        b=EDX843WZGQN0nzfvBgA5OEdM1tGi7qb2uCkJoarlc9K6m3i9+sdHDU7bDQI//6+5K6
         0uZZcTPZDax3aFNEqwEDTrVGBV9dN3xd1GGPlqbEkvxWeBmJZf92sESzXKQ8bdorD+iZ
         aiEtzOeWjbRT2YRcGxtZVeGOUr5dYPljUem5xkzjDXjkc6GFzmWg/6rtoNpVThOml2Ki
         hGbjP6PoueMBWvRKKG92DN/2c1uT8g/OS5Ib13DKWfSRdTGXDRgtR28/X2jlVlO2dDt4
         7lzy8Z1E7+NB0ig39CZ89hAVH9ZxZxYTv9AEh1Dl5e9Y7lBn9zD9t81cTZiXhQCfNpF1
         +rLw==
X-Forwarded-Encrypted: i=1; AJvYcCWBkFUIlw4uTIHQludwZDSbMLCvj2HamKJ/8VTiYflo5p4NAnRXLbfDrpSj4qZ9tZSbQrulMe7hnSnSO+wLKWMBUvgbLvbbueSHuwBO0cOS
X-Gm-Message-State: AOJu0Yz3BTjWr8zvgV744+sDXpZEKab/9usZle4e0yK7opt4kBVFbfXV
	gbALL2rFLvWKY9tVDQsuwNjerZ8+gSTSOByw5jXR87p3K9hcUd5WpkoKsjMhBg==
X-Google-Smtp-Source: AGHT+IHrjjh8uwOGfKisJHpLEa0Atyc/w3DC95jENvS8m/9tWBeTRxSog9SPn/yX99K3zySiGpAi+g==
X-Received: by 2002:a17:902:c946:b0:1dc:f989:3116 with SMTP id i6-20020a170902c94600b001dcf9893116mr1689963pla.18.1709633431171;
        Tue, 05 Mar 2024 02:10:31 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d50400b001dcf93e90a0sm6282358plg.20.2024.03.05.02.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 02:10:30 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <keescook@chromium.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-mm@kvack.org,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jann Horn <jannh@google.com>,
	Matteo Rizzo <matteorizzo@google.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 7/9] slab: Introduce kmem_buckets_valloc()
Date: Tue,  5 Mar 2024 02:10:23 -0800
Message-Id: <20240305101026.694758-7-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305100933.it.923-kees@kernel.org>
References: <20240305100933.it.923-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1268; i=keescook@chromium.org;
 h=from:subject; bh=k3ROePG0wD7icc8xiWOerLraaHU6zkW2VMYF75ammOw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl5u+Q3E2uwV8NIpzb5dXDsQuDADvQD8oEdZqqt
 GBc07SpeUKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZebvkAAKCRCJcvTf3G3A
 JkIREACdPvVBaWa/0ViOnT81LdqxheGCGDtUUmVO8IhLpzHQI2rh/b5CfK7msJHDhECQIcRrSdi
 9nheGlO4Ww0GdAzyGQiuG+uKl+8tPoMsEDmLN9mYMJzOFVR9qtmtiAj8CWKbMecilAJj7/jLqds
 iCJqrBzYT0DBMPzR+RZ9sy4+mqmsXB8/VLVTfQt56mISQNPQ4HxWJF2ILoadyqB9vPcefR9U1EU
 OzMaLq1/npProPdec6qADdEauw08Z36eJCQphHgRvJ82WAFVrMNxpshJ6EMEpBpK8K5rISvVsar
 aqXEgU6wRqJfn9CHNyLBKbNEsewc+MTNzTH6kW30tWM/d0EuaYIykGXqwZFz6ALQ8Drk6s3yo+u
 KN1Nb+BF9a2zqYfrY9DNDIRvNra8AzrHVlKP3RHbTjzJDcvZDyjoEkPmDR2fCR2H+Z0kdexLb2B
 kk584A9xUsXzzD2J+uVGtk6XiiRF9RMheuM13Hn5v4gt4o/evttZNtO2TvSMEgiYlV7G77+lk27
 THKPCHQ33k+oMkMYU93Eun2edSp14I5OInVVbt0+av7+/C3NRYD3Li2IJNOs4cX4OpXAliq48bk
 jKoGMk0FoWujDweGgEaojZtYDuVb8Uyxqw3TBzo2P0/2LUFvkVfm1Ovlo8NLjCSYQ6x2M+f71mk 5bgLk5y9jX9jonw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

For allocations that may need to fallback to vmalloc, add
kmem_buckets_valloc().

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: linux-mm@kvack.org
---
 include/linux/slab.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 7d84f875dcf4..0cf72861d5fa 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -740,6 +740,12 @@ static inline __alloc_size(1) void *kzalloc_node(size_t size, gfp_t flags, int n
 void * __alloc_size(2)
 __kvmalloc_node(kmem_buckets *b, size_t size, gfp_t flags, int node);
 
+static __always_inline __alloc_size(2)
+void *kmem_buckets_valloc(kmem_buckets *b, size_t size, gfp_t flags)
+{
+	return __kvmalloc_node(b, size, flags, NUMA_NO_NODE);
+}
+
 static inline __alloc_size(1) void *kvmalloc_node(size_t size, gfp_t flags, int node)
 {
 	return __kvmalloc_node(NULL, size, flags, node);
-- 
2.34.1


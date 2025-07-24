Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5622DEA96
	for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 13:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365387; cv=none; b=H1isPSuaF5alLtF6rBeYis5Ja5AjO49n3G2gq8sd17gA2MxPdqNfrazLPBtSoCrJBX8/2lVuvHjFH6fL5aKQXeUX1jwZxsEsREY2AG3n1JSyAZDTwzMJyKUNodgufu6+jY7PBqY8FmW/C58U1F4NGokE0MAvIM7Bnh6Cl0KgwSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365387; c=relaxed/simple;
	bh=PINfP31Uv54+8D72YX70+7lUeVH3jRfFjtvMSeM9ulU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+qEOzDNYTBtA9gQVCle09SQQUz3z+ZaejuvGFT00Agk4XhRzcx8W4tJjrZom83ZEI9FxPbwab7cZJk7yjeeR+jjMadDjJnqOYbM8ayKHaE6WcBwMs0KReL8QeRhz0LznBFcFM6vCpYoy2atHlYQ0jB8Ss/CeLZRGAEGW6E5ho8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bp7O1/Q3; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bp7O1/Q3"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-451d3f72391so10094445e9.3
        for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 06:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365383; x=1753970183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5bTh+3Vvg3yCOBzS0gI9x4Skq8JpHTqDTkP6m6Co9I=;
        b=Bp7O1/Q3xvPEVICeaOTeyvLwuJmcqeC6zqp6qljZd4e8DpedmERDcwLOVnUVDnHqE2
         vwsEWtJGw9MtgtqxByfudKP1LWy+zCilrblNqpWH0i4+J5r36qMVtI/vcPrI3OarHxaF
         aCZZabPT6gCXK7tdLIkqSttj30JiVCZ8lIxpO+5yd/PLXSYC0HfLNu0vSIVSq0bOm0La
         Li/7IyOC0ncduiJZ87UI5oh7+LJWRSbqzUmaADu8dJDSUGC2/VKq4gaHzE9R/LPm3p5E
         722gEpNB4LzPNtfrzZ6W4+dthepbkpmdeMMUr02SzvjhIvjbZjX5U2wQKt0KfYJ3tnFz
         Grgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365383; x=1753970183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5bTh+3Vvg3yCOBzS0gI9x4Skq8JpHTqDTkP6m6Co9I=;
        b=R/DCxfoaWR/fhkGhoKcPqbAuFG7oPtr9tj0sqgavJ6JrPYECRh3HdZRa/J2MEqr0oX
         ndQfbrKLhOH8zNcOOKSrw9ly36PzUQUq1bkweFsgRVFqexHrcM+fTkvwrG8U7EJVzMYg
         51C2cTfDs0oMZPDL/DGe3EUnQvI6f2E/xhifz/l8wggcoFcP8WUkJQbxSefE/Nb0sawS
         PJF9PWLL+/PlAiBP1AeMcb3dkm3XUkEA4YMNNhYoOiJ2nDdtRlYFX57dZ1J4I8FBlnKj
         sk4Lu8cGzLUkr9c+6FlT0nBjMsCkcMQek6SaQ9UTCNDmILJHXpDyudeehZOTba+FCL4/
         Oxgw==
X-Forwarded-Encrypted: i=1; AJvYcCWF0oaljrHpH7s3Zs+TcXtIvfgX7jGzyj4LSXoEJJJu/W+7lS3PX6V6D6lhFgpzTlMAgJV523pnvuAr/W4Xhrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAJ+f+AKf2FyeAnq5CxG/B+458tXtQAar7Zgl7Wd8HsFGCk35u
	ChIewsBhZnevVNOxmEXFS7d5zyN8YPAEFl9RcK1JVrH3VVAWodCudR/Sk3BHqvS0qiM=
X-Gm-Gg: ASbGncsoOqLpeGdXd60+maSMlUbmvW9TtH2YBCtN5c6utyuj2jd/37ZlUfwjojucdWD
	3yndyvEUsWveBizdqxojScRQupfkb41X7KjckjgeRBddcKjvfZa6IcOiKj193oPZEwxKoDVWH0r
	5o1UpMWFZ4uVdE1tAigZLIfyo47RPEV6mx4a+8JW6Gim++Iqv5GXBS/VVFRagS2JNXiIwfoYHIf
	2V6cv7Im1mlhEvyEpXOUhmxvIZxNhY2dhra5U0G2tCyxS6/sV4cDCzjQ7XuoiKFUb9bzFoXxnbj
	rBsbtM5XBgqal21lwp5CB7chBHOKeD+VdZeLRsvvhSopStod8ZRUSXigwURhOsHbJVIfGSVETTZ
	CZcNlwzSK0f3SPZmaH/7OwMmZbSa6O0e6hcvEC1MDGV1RZ12P5uJW4YN0sfVYBDnXbOAqHg6X6h
	UWYx0tbiDGEsyl
X-Google-Smtp-Source: AGHT+IEIzq0FBEBm3LdZcFOEY9/KwPes9i1IaDCT4onRneKKA+Xc4u6PgwWHdq2thr0dEpYstk90ZQ==
X-Received: by 2002:a05:600c:4586:b0:450:d4a6:799d with SMTP id 5b1f17b1804b1-4586a8ce621mr55841895e9.7.1753365383404;
        Thu, 24 Jul 2025 06:56:23 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:23 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	eugen.hristev@linaro.org,
	corbet@lwn.net,
	mojha@qti.qualcomm.com,
	rostedt@goodmis.org,
	jonechou@google.com,
	tudor.ambarus@linaro.org
Subject: [RFC][PATCH v2 02/29] Documentation: add kmemdump
Date: Thu, 24 Jul 2025 16:54:45 +0300
Message-ID: <20250724135512.518487-3-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724135512.518487-1-eugen.hristev@linaro.org>
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new kmemdump kernel feature.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 Documentation/debug/index.rst    | 17 ++++++
 Documentation/debug/kmemdump.rst | 98 ++++++++++++++++++++++++++++++++
 MAINTAINERS                      |  1 +
 3 files changed, 116 insertions(+)
 create mode 100644 Documentation/debug/index.rst
 create mode 100644 Documentation/debug/kmemdump.rst

diff --git a/Documentation/debug/index.rst b/Documentation/debug/index.rst
new file mode 100644
index 000000000000..9a9365c62f02
--- /dev/null
+++ b/Documentation/debug/index.rst
@@ -0,0 +1,17 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===
+kmemdump
+===
+
+.. toctree::
+   :maxdepth: 1
+
+   kmemdump
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/debug/kmemdump.rst b/Documentation/debug/kmemdump.rst
new file mode 100644
index 000000000000..3301abcaed7e
--- /dev/null
+++ b/Documentation/debug/kmemdump.rst
@@ -0,0 +1,98 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
+kmemdump
+==========================
+
+This document provides information about the kmemdump feature.
+
+Overview
+========
+
+kmemdump is a mechanism that allows any driver or producer to register a
+chunk of memory into kmemdump, to be used at a later time for a specific
+purpose like debugging or memory dumping.
+
+kmemdump allows a backend to be connected, this backend interfaces a
+specific hardware that can debug or dump the memory registered into
+kmemdump.
+
+kmemdump Internals
+=============
+
+API
+----
+
+A memory region is being registered with a call to `kmemdump_register` which
+takes as parameters the ID of the region, a pointer to the virtual memory
+start address and the size. If successful, this call returns an unique ID for
+the allocated zone (either the requested ID or an allocated ID).
+IDs are predefined in the kmemdump header. A second registration with the
+same ID is not allowed, the caller needs to deregister first.
+A dedicated NO_ID is defined, which has kmemdump allocate a new unique ID
+for the request and return it. This case is useful with multiple dynamic
+loop allocations where ID is not significant.
+
+The region would be registered with a call to `kmemdump_unregister` which
+takes the id as a parameter.
+
+For dynamically allocated memory, kmemdump defines a variety of wrappers
+on top of allocation functions which are given as parameters.
+This makes the dynamic allocation easy to use without additional calls
+to registration functions. However kmemdump still exposes the register API
+for cases where it may be needed (e.g. size is not exactly known at allocation
+time).
+
+For static variables, a variety of annotation macros are provided. These
+macros will create an annotation struct inside a separate section.
+
+
+Backend
+-------
+
+Backend is represented by a `struct kmemdump_backend` which has to be filled
+in by the backend driver. Further, this struct is being passed to kmemdump
+with a `backend_register` call. `backend_unregister` will remove the backend
+from kmemdump.
+
+Once a backend is being registered, all previously registered regions are
+being sent to the backend for registration.
+
+When the backend is being removed, all regions are being first deregistered
+from the backend.
+
+kmemdump will request the backend to register a region with `register_region`
+call, and deregister a region with `unregister_region` call. These two
+functions are mandatory to be provided by a backend at registration time.
+
+Data structures
+---------------
+
+`struct kmemdump_backend` represents the kmemdump backend and it has two
+function pointers, one called `register_region` and the other
+`unregister_region`.
+There is a default backend that does a no-op that is initially registered
+and is registered back if the current working backend is being removed.
+
+The regions are being stored in a simple fixed size array. It avoids
+memory allocation overhead. This is not performance critical nor does
+allocating a few hundred entries create a memory consumption problem.
+
+The static variables registered into kmemdump are being annotated into
+a dedicated `.kemdump` memory section. This is then walked by kmemdump
+at a later time and each variable is registered.
+
+kmemdump Initialization
+------------------
+
+After system boots, kmemdump will be ready to accept region registration
+from producer drivers. Even if the backend may not be registered yet,
+there is a default no-op backend that is registered. At any time the backend
+can be changed with a real backend in which case all regions are being
+registered to the new backend.
+
+backend functionality
+-----------------
+
+kmemdump backend can keep it's own list of regions and use the specific
+hardware available to dump the memory regions or use them for debugging.
diff --git a/MAINTAINERS b/MAINTAINERS
index 7e8da575025c..ef0ffdfaf3de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13620,6 +13620,7 @@ F:	drivers/iio/accel/kionix-kx022a*
 KMEMDUMP
 M:	Eugen Hristev <eugen.hristev@linaro.org>
 S:	Maintained
+F:	Documentation/debug/kmemdump.rst
 F:	drivers/debug/kmemdump.c
 F:	include/linux/kmemdump.h
 
-- 
2.43.0


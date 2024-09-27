Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1456D1C231E
	for <linux-hardening@vger.kernel.org>; Fri, 27 Sep 2024 18:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727463140; cv=none; b=bYudBgPDFJxyYVuPPCcAZRKL0piZxdsGJ38BnfaZVNxm4WFp7iTG5wlCgtKul3tde5xNaJiyNeS1+TuGhRCqe+tyh5aQIt15FdT1iv9AMWFVtkRLKdgLJlqfrJ8jFWOtMzEr/0/zhh8nqK+bqaZxjheOs7kSHOWYl1wLDzll+CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727463140; c=relaxed/simple;
	bh=CgVxO7j7fcIwhZ8sGJOfD3oqD56qz+Htb/d2q9B8S/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IjLHieQ4rINSqKgF8a2qb7N56WR4O8NZ9tJ4AIAqV1leriMEJ9qlSYl3TZ6SmlGHAYEoLnu4GGT3vsRTsLakA0s3D2auZbPACuOEuFdZNitnBg7XeqbveBGfaWGn3GFlSHF95MPOR8hLmEjoMeKG0+2tOBeAZZ6f9ClBC6yIoyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fxPvMwyb; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fxPvMwyb"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7d50ac2e3f8so100130a12.2
        for <linux-hardening@vger.kernel.org>; Fri, 27 Sep 2024 11:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727463137; x=1728067937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tjNTTjSP1D6OLEEAIGyE9s8gzDaTa6XxG0RsJUdZJBA=;
        b=fxPvMwyblRQ3qxDvCrQQpxwMycRjXr7B6dO49ipXVzJ/2AgSEIssr8urLu6pwOvNq5
         HrEaos/0Wx0qbZDdgx/HY6ofh1Cewqgt91JjpFUt3yNnQENa0HDeic2mpjPxNSDbW/fW
         qdoE8O4n254AB77a79oZptA7zu22IjVCdn/g4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727463137; x=1728067937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tjNTTjSP1D6OLEEAIGyE9s8gzDaTa6XxG0RsJUdZJBA=;
        b=Idl6WTQNyxrg1QduJ6Eg90L99F+EqE6fkahybNr4CH4rxsY+RRqXn6Ld9KYmiK8vnj
         TsR3M3DWuYB/W3zbm9tJMWAW9oJY3338J1liUsN1cbRDcTQVzVEyCiteBUMpvN2HAjbz
         4FGWXgcJ3WjrFvaxd/GsXbn1as4S6RTplRueKVYPdnFOWzt/tzO5+62zuKodwyGtpvax
         bQjurKDtPn3J1gmOJaQYQr4hINMdNqL1hJyHNGDmYV0gVCOtgJfic4/ou6kheqdIeSX2
         7HNEqZW2V2W30dSy73uaCFh+gh5BrcEkK2FyD+tFdqYqIINR3OZN3jT3AqKxlZfHwmxJ
         NoTg==
X-Forwarded-Encrypted: i=1; AJvYcCU9uAClOe6KjwBC2mUbs7sVzgufB5T1PZ5j7cp3RHjQyVB9L4viTk1Xtw/aeaKL4bmG3rVO4MC8UYYfeaCol4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaR6tO+5lQOZiMlxkobBwDKBIiwIzWIeBOjQA8CaBdqs0GjY17
	4+TjCPTzfhcXaRXFQwCrQC6kSOum+lMgeXjue7ac39fHuhhk2DLO4vBiczmlQA==
X-Google-Smtp-Source: AGHT+IF0HtH1+PEmCntzA1h5vec66p92JMnSHwfX+hTVjrGe8VMsda+UKDIBB/ShNgo5UqX48lyoGQ==
X-Received: by 2002:a05:6a00:b85:b0:70d:2c09:45ff with SMTP id d2e1a72fcca58-71c636f23c9mr339784b3a.4.1727463137261;
        Fri, 27 Sep 2024 11:52:17 -0700 (PDT)
Received: from localhost (99.34.197.35.bc.googleusercontent.com. [35.197.34.99])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-71b265385fasm1922905b3a.216.2024.09.27.11.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 11:52:16 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	corbet@lwn.net
Cc: jeffxu@google.com,
	jorgelo@chromium.org,
	groeck@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	jannh@google.com,
	sroettger@google.com,
	pedro.falcato@gmail.com,
	linux-hardening@vger.kernel.org,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org,
	deraadt@openbsd.org,
	usama.anjum@collabora.com,
	surenb@google.com,
	merimus@google.com,
	rdunlap@infradead.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	enh@google.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v1 0/1] update mseal.rst
Date: Fri, 27 Sep 2024 18:52:08 +0000
Message-ID: <20240927185211.729207-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Pedro Falcato's optimization [1] for checking sealed VMAs, which replaces
the can_modify_mm() function with an in-loop check, necessitates an update
to the mseal.rst documentation to reflect this change.

Furthermore, the document has received offline comments regarding the code
sample and suggestions for sentence clarification to enhance reader
comprehension.

[1] https://lore.kernel.org/linux-mm/20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com/

Jeff Xu (1):
  mseal: update mseal.rst

 Documentation/userspace-api/mseal.rst | 290 ++++++++++++--------------
 1 file changed, 136 insertions(+), 154 deletions(-)

-- 
2.46.1.824.gd892dcdcdd-goog


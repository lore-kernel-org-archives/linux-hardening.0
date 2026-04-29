Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B4F3F077B
	for <linux-hardening@vger.kernel.org>; Wed, 29 Apr 2026 11:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777461829; cv=none; b=dgCePuivyqJMtl///X0e4KSg68T4OTN1jsRXbTTsTcN5y7f3Zaw5QebsaONNm9VRqHq8fi8l88ayXv+1lg+AP44iMfLILYYijZWkssz7Azm+X5FBABDXV0ih/yZBxZ2d7VkNO5y5Ff/O6Rjp4qtWjj3hGS8ASsR1tcClbjxF95Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777461829; c=relaxed/simple;
	bh=mfFWITegxVr7OryhNdWaTF4wrDdhYnDsSWg+PbDZrjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dR5GYWoN9QsGcRUpmNozl/qHTELAOXHpBunfFaW5qbZENk5Bpm8Aym8ULMYExB+wrjqB5G6GKYM2dYEJUEtsf07t8chr7+DN7R/yeSJypu0UGeTrPVFVhJ3Ikc1OdX3O6sBiZ28cZIsxipu73er1wjCc2Y/hnFDLfVrQO2qslVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JKsYPXgP; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKsYPXgP"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-362e50b4641so3814226a91.0
        for <linux-hardening@vger.kernel.org>; Wed, 29 Apr 2026 04:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777461826; x=1778066626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LOwUkZgxEayoe4p/g5oQYfOZ+RJPUJOIECEzsD9pXT8=;
        b=JKsYPXgPbn0DpUvOEWLQ0LX+Pa73qlI9ypF9MYweq17/JmWaLLMKrfY73vIUMMdErX
         chZy8tWYiz1M1Sy8MJ91cuqerbylE9jrmYyP5FPEPk5rP8SrKWrV2EBAV01oISagLfP/
         c9LN98PGZe6K7Xs+/sdnBXE413iNHVDgx9eP0US0Na3GmNuOoDfQPjLFn1l7z7gp5E32
         L6lHxHgrZX+s/0mRGhyxvJnu/CvWxTOKAJA3fYH+Qtr2qFyRJDDJwwSSb0Dt5b4M88Bm
         y09hMb1ouDnWipXvJmWN/yn7UQLGYwzJU/wrxU8Tb6BsQb9BG5r2qgrXOc8Gjw805R/U
         Lm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777461826; x=1778066626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LOwUkZgxEayoe4p/g5oQYfOZ+RJPUJOIECEzsD9pXT8=;
        b=kS9EnDJhPz7x+7sXRHqGpzzZ0MVB5vj6TkpEze8Vb8JI/gzVriXE2fKpBXBhQf36wW
         YU1hGetTtA5efqLUvibQl83p2Dr+ZjT12AAhfNCk8uRT6Kv4DbWAutQHWVb+Gh0NGk6Y
         X3MpVTvs9Mqsu2AdwFfaMh9tlDCmTDuifCMhnSDMd8dLWAmaTRGSQShbqBVRkmeD3Sqz
         mlxKt76fdoTinQjNkMifJ31E39X9JaWQ5M5yUKA1kB4GioQMXUlfTKmcGplZ+AZD7szz
         kwUIYLoJ8Jaxx+QPpI4xJrmi63/4ofHwIzwJlnj4bnT7Vu060i7siuAwEmcsdHezv/fj
         sQQQ==
X-Forwarded-Encrypted: i=1; AFNElJ90KgCxJZ7s4wcFr/W10MmBZ2Oo4hNW+XtAkkp/d9R9Z/5/Vev3WOOoNxnLlBpvyZrudqqV2zrRRXs66xNIGMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTqorBVzvbZCO4Rw0RrXZJI9L56KATqDyqcpioSuTEKjCvvJRi
	89YyLOhsVEg4rcVc20+YrZX56LmxplcnLQNcBp/A4dkxHxE0Cq8Kuu/t
X-Gm-Gg: AeBDiev/Dh+QDL6FTuAJPLD8BN1hT6eR/8MC/h5R0EEtq8tdo5wPy7EdUmYfJGbjwZd
	VnsR8IkgqTZ1c7wK/hMs0M4AVUX/YWT6Je2kGdZywWWOjT0kB70qhMhvGmITsQxFKFohP584Hf0
	bSqIFcYkYyRQD0yGhS7zT/vfPdz6RYfmNDLIBAQEzcWqRXhnzhxR1bvntAiHmq33U/Ip8cqIAX7
	ilP2w0YAut6z0sbJT+dkiWzEmzPh4yWMU/tXXDMs3po66FZznovwCRQL52Qxorp1H/TM2kc3GGv
	A5SOKTywOprelrjtKMxNLt4AkFhT8a7zjgl3GaJzyh6hAr5d+fXMHmflnaHLn0l3Kbs6/1BIj2W
	jMi2Fefc84Feuikluo1Fj4zQd5a2byVSK48F8KCoyW42/wQzfSmre1f/WUzHvfE6HJ16+DCjN62
	SE3eOjX73pDMFf24RDvGvp1NBz2t0hRqhKfjr3fkU1j1PRf7uS/nw=
X-Received: by 2002:a17:90b:35c4:b0:361:423d:2026 with SMTP id 98e67ed59e1d1-36491fce3b5mr8910713a91.12.1777461825634;
        Wed, 29 Apr 2026 04:23:45 -0700 (PDT)
Received: from localhost ([103.74.250.37])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364a43938e0sm2672020a91.11.2026.04.29.04.23.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Apr 2026 04:23:45 -0700 (PDT)
From: Jiazi Li <jqqlijiazi@gmail.com>
To: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: Jiazi Li <jqqlijiazi@gmail.com>,
	linux-hardening@vger.kernel.org
Subject: [PATCH 0/2] Add str_alloc_free()/str_free_alloc helper and related rules
Date: Wed, 29 Apr 2026 19:22:18 +0800
Message-ID: <cover.1777369070.git.jqqlijiazi@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently finds 4 locations:
./drivers/net/wireless/realtek/rtw89/fw.c:2557:7-12: opportunity for str_alloc_free(valid)
./drivers/net/wireless/realtek/rtw89/fw.c:2693:7-12: opportunity for str_alloc_free(valid)
./drivers/android/tests/binder_alloc_kunit.c:196:6-21: opportunity for str_alloc_free(alloc -> pages [ i ])
./mm/slub.c:1634:3-8: opportunity for str_alloc_free(alloc)


Jiazi Li (2):
  lib/string_choices: Add str_alloc_free() helper
  coccinelle: Add rules to find str_alloc_free() replacements

 include/linux/string_choices.h              |  6 ++++
 scripts/coccinelle/api/string_choices.cocci | 38 +++++++++++++++++++++
 2 files changed, 44 insertions(+)

-- 
2.49.0


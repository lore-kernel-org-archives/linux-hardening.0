Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9EF1B960
	for <linux-hardening@vger.kernel.org>; Thu,  2 May 2024 22:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714690420; cv=none; b=nThY03SdjPo6pgxpG4f/oeN3CKu9D9CFl4VOvYR3eG5F33Dl4QqNdv4SmT9WFQADIvGcLvX2O1wm8nTLR1DZ59L3BISdYIyGIgsomNPODouC2EGZpE/9Q75qnGQ8yhPsqV409tnr2u5eKAfNQQlWoHxq3iajudd2L2SIjbN6sPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714690420; c=relaxed/simple;
	bh=qUMv2aw1IBS2/MX1SbOITzDsbuweO0Qs3rgm+IfknbU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MZHR1AWDhHJeL2zWPTarOkvTI1t0nSf3kWgHoRuY1WdqRj1Ys+jnbTaQwO9dPH7Rcmt9FX4gsv6wTrOm7AKCrfhJbJ2/ExWplNHI9t3UvS2WAMf/LvoA8GIv88ecRmbhAAxYBhCujlWjy+pQ8Ltb9BS8I4FdSzk0hMOkVtIiEJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=og6JPJaB; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="og6JPJaB"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ec4dc64c6cso28197195ad.0
        for <linux-hardening@vger.kernel.org>; Thu, 02 May 2024 15:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714690418; x=1715295218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Prj7tW5O8qcWFBoqOh3lWUNMlvI33+jglppy2rwSGbc=;
        b=og6JPJaBGKEXLvEo/y/OKfRnC+a0vpebeaMZNoZ7F0tR2izXWCBatM//89bgaE31H4
         j0E8BAt2mt//bbPFSJ/RtfEegIcLSID3wgPkQjY9dWK414b8PUXPfK7rqFp8g76RVhlM
         KCJpFkId2+BHWXshSKDcMPskxwWi1+B4xSi7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714690418; x=1715295218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Prj7tW5O8qcWFBoqOh3lWUNMlvI33+jglppy2rwSGbc=;
        b=sHvf6qeQgodrCTm2p/LsbffDhnrWdwbDLiOQP8vWt0gEVJtk/66PmlT/IW5q5NOROP
         syUYvOdVRTKNXbSZc9XQvrTTNq0G57QxXcBcwNBSCS5cIv71kvm3Cfj8cje4ydHMAYDA
         PuZBboSocWnkfH9yTE9CcWK43kQyfq6hem4qr88gpbyUAUzW0qFsku6OoeBLgl+pE+ch
         tcO/pGckV+jhmxwQs7D7FxqTSpiMdW/fvnf1mznnFyHmxokyLumVrmek5OHO92GmPHO4
         nkov1ZBy9guYLmffHSfCcIybKd1kLJPeuKZL1wXdr2vZ9q7XTER4WN4vY336jOV018qT
         vqIA==
X-Forwarded-Encrypted: i=1; AJvYcCWwORXfWcm2Xnd/WU9J2SMcx4Vzizic/cTzYXi6Nobn5CXYqJMkyuWEHtqh7AO01ctLA86qBN9tTxSyWO9I9KoQLwtpzflF9yxYqRSLYMj1
X-Gm-Message-State: AOJu0YzfhPKAPWGw1ARv6bm4adQnX4iXzjt3XBQOTg5OLSoF19y21NzA
	/Q103c9LmS5RivBwAzCm2knWa38bzzjcCE+8lITnlo3BOHwiVsTZ85nkkOzQPA==
X-Google-Smtp-Source: AGHT+IHShwmEv8qkRbopVbvA6FjoqnEI0cCapniOQAPLT4x/TWMx5CxRoQ+FGxV/tw4yrYm56Lt/4g==
X-Received: by 2002:a17:903:249:b0:1eb:d70c:e69f with SMTP id j9-20020a170903024900b001ebd70ce69fmr1155777plh.63.1714690418369;
        Thu, 02 May 2024 15:53:38 -0700 (PDT)
Received: from localhost (238.76.127.34.bc.googleusercontent.com. [34.127.76.238])
        by smtp.gmail.com with UTF8SMTPSA id d9-20020a170902cec900b001e20be11688sm1870428plg.229.2024.05.02.15.53.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 15:53:38 -0700 (PDT)
From: jeffxu@chromium.org
To: ryan.roberts@arm.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	dave.hansen@intel.com,
	deraadt@openbsd.org,
	gregkh@linuxfoundation.org,
	groeck@chromium.org,
	jannh@google.com,
	jeffxu@chromium.org,
	jeffxu@google.com,
	jorgelo@chromium.org,
	keescook@chromium.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	merimus@google.com,
	pedro.falcato@gmail.com,
	rdunlap@infradead.org,
	sroettger@google.com,
	surenb@google.com,
	torvalds@linux-foundation.org,
	usama.anjum@collabora.com,
	willy@infradead.org
Subject: [PATCH v1 0/1] selftest/mseal fix arm build
Date: Thu,  2 May 2024 22:53:30 +0000
Message-ID: <20240502225331.3806279-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

This is followup on arm build failure reported by
Ryan Roberts [1]

I don't have right setup to repro the issue, so would need some
help to verify this in arm build.

[1] https://lore.kernel.org/lkml/f797fbde-ffb7-44b0-8af6-4ed2ec47eac1@arm.com/


Jeff Xu (1):
  selftest mm/mseal: fix arm build

 tools/testing/selftests/mm/mseal_test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


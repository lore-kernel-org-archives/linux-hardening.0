Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0F81B3B01
	for <linux-hardening@vger.kernel.org>; Fri, 30 Aug 2024 18:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725040964; cv=none; b=F/EC5IvHA1YYXzTNM6NqoAhPk5zlwOlqYw32S4sZZBwqJnNhQyfFhwnugm+bpxMor2Wbsu0QeipgFepNmPTqEKo7mL20lG/UPl8LX9UT7b2hG4xZNUc1v4ya6U2oSYSwJKfYj9/L6nQ67IOKPwpoh61vUVRDCPGOk9SMmiUYmTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725040964; c=relaxed/simple;
	bh=T3aBJ9fnmYj5an6GZeg3uLH3LGkl+XZDCDWyiQZyo/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JrK//Vy/XIv2hOSTNaoALftDnnNjv7a/xokhaBW/OX+YZnB7qhT/04Yy6WJ8Oz8vOiJHRxmFDuwrFyLd+Lx0j+N8Z5p+koZ78DzNR8fghRAYPbDRgcYF4H/n4W6AQWLYUDtiIlfRKZfOLSlZdY0IhiI1J0Ai8gwwd94OJUuEkI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AnHHLPis; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AnHHLPis"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20543c6f3b5so191675ad.0
        for <linux-hardening@vger.kernel.org>; Fri, 30 Aug 2024 11:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725040962; x=1725645762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w7BWq7oVdU2RJCnx+Dm004xyt6dkCplP5f/XTiAPqqc=;
        b=AnHHLPisqQVt//9IJIJ9+MsSngY4EUwaI5DB71ABvYgKXN4aNizEdQ6rImw6azABbz
         s+PLk4LK+MrOiI8o39XrQHQhEtM1SppV08pGYrRpALXcaaPZfDNa0wlLbJuqVfYRZl90
         SLSF5mO6BgLfyIZkNxChrA+TZ7Rgv/56ZCQ30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725040962; x=1725645762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w7BWq7oVdU2RJCnx+Dm004xyt6dkCplP5f/XTiAPqqc=;
        b=v4HnHCSxExEBmXO2sQDYhyqHgkGOf74xhDGYlgcLKYJ8MG+3Zki2Tf1yTDVcDq7TTX
         IYehKsp0CAI8srI7i42s1Ezs/SNfwA8nU666JQvGeE38w45X+sy6sGkE3uN39jeBGVms
         m/gUlI9NJ+owzVugyHYvKbYxHdSej3OSeaSLDA5w8ajvsfm2Tdc92HU02ClHq6T7ErTG
         KQ6tZxOLt/gN5w9vJZ6ZEHC6MriSWs5ZRBon1VfUJd+p2XEil2b4Fu1D966WYgI+SwtP
         eI0voqT6ApuyVrQ6G85910wLNmCzSq3KIimkW5FkBhGE8YgF9i5ufERNB7YOw1jRPhiJ
         4aWA==
X-Forwarded-Encrypted: i=1; AJvYcCXK1zAhvZal2JugXw+vzsjk/7QsJWFXKDo8IaIVrcrapMyJ0w6ge0k+M/kE1bAoupZ5w7JNacnRdHX9AaKUHzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUa45Eifn40gQqZuABvMoTE9LZ/t6ANoFKKT46cCdonl5P8Eud
	SrwPGd2c1ZPCAchlSyc6YmP1hFyiZh1+avA50xBhFoBdsJuFox/aZCAnQT9DNQ==
X-Google-Smtp-Source: AGHT+IFfg3nmCpS6l8tCSIgiK8ygtmcd3GUg9HFT26UxW+AIXZxfWCUoJstGo9qdujnZ6B7n8WVNZQ==
X-Received: by 2002:a17:902:cecd:b0:1fc:5cc8:bb1b with SMTP id d9443c01a7336-2052773ab73mr19021075ad.7.1725040961241;
        Fri, 30 Aug 2024 11:02:41 -0700 (PDT)
Received: from localhost (150.12.83.34.bc.googleusercontent.com. [34.83.12.150])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-205155671bdsm29574215ad.302.2024.08.30.11.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 11:02:40 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org
Cc: linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pedro.falcato@gmail.com,
	willy@infradead.org,
	lorenzo.stoakes@oracle.com,
	broonie@kernel.org,
	vbabka@suse.cz,
	Liam.Howlett@oracle.com,
	rientjes@google.com,
	keescook@chromium.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v3 0/5] Increase mseal test coverage
Date: Fri, 30 Aug 2024 18:02:32 +0000
Message-ID: <20240830180237.1220027-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

This series increase the test coverage of mseal_test by:

Add check for vma_size, prot, and error code for existing tests.
Add more testcases for madvise, munmap, mmap and mremap to cover
sealing in different scenarios.

The increase test coverage hopefully help to prevent future regression.
It doesn't change any existing mm api's semantics, i.e. it will pass on
linux main and 6.10 branch.

Note: in order to pass this test in mm-unstable, mm-unstable must have
Liam's fix on mmap [1]

[1] https://lore.kernel.org/linux-kselftest/vyllxuh5xbqmaoyl2mselebij5ox7cseekjcvl5gmzoxxwd2he@hxi4mpjanxzt/#t

History:
V3:
- no-functional change, incooperate feedback from Pedro Falcato

V2:
- https://lore.kernel.org/linux-kselftest/20240829214352.963001-1-jeffxu@chromium.org/
- remove the mmap fix (Liam R. Howlett will fix it separately)
- Add cover letter (Lorenzo Stoakes)
- split the testcase for ease of review (Mark Brown)

V1:
- https://lore.kernel.org/linux-kselftest/20240828225522.684774-1-jeffxu@chromium.org/


Jeff Xu (5):
  selftests/mseal_test: Check vma_size, prot, error code.
  selftests/mseal: add sealed madvise type
  selftests/mseal: munmap across multiple vma ranges.
  selftests/mseal: add more tests for mmap
  selftests/mseal: add more tests for mremap

 tools/testing/selftests/mm/mseal_test.c | 830 ++++++++++++++++++++++--
 1 file changed, 763 insertions(+), 67 deletions(-)

-- 
2.46.0.469.g59c65b2a67-goog


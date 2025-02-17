Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612FA21767B
	for <linux-hardening@vger.kernel.org>; Mon, 17 Feb 2025 10:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786817; cv=none; b=Z8kILRfyF+FQ0abt14PpcgeWQWBw7v126usrSPb3hi9VV0LH33TJVugwUOwBFphfamEBynEfWLi/z3gRSi7g+DD6h5o9AUcastDYbekLWzLL/qqZtzlxnkQdSp0Vc6iRBNa3ugnJdcGV00H7jbczQjYGBo6EuN32hOW8/XqQlwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786817; c=relaxed/simple;
	bh=Biw6DUxzk939fJknAJPcsYdiS9No9FiyXZeyYUMpkmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=O80eH1tGBuvGIKInfoTZtpDtynsDtm5iNjcAc2WpHMXr2v7vJDZEGsgh577A5feifPgkWsqup4rIoh4VIlzukW4dR3x4mHtQhfhogjBY6D/TJaa/g/wnLZplI6DMN8M+q/qKHy9/lwn3J/V80ufVEmnnUmF49VAEvWLpmyLwMIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IDJaRlum; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IDJaRlum"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739786814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7uYWhEd1/c+mNMCq30U6Kc7sDjWCoVhIrgohc+6hGoc=;
	b=IDJaRlum/U1U84Oj34bGHuHMEtJBty4AFk4Mw8x9dOP3zCKSq9cyoUhlxNWGKWUWnaFmTq
	mWCVrEq33sRook1+YnBjXfuEVYFuN4E7acE+EBvbk3doB+UocwQWza+lvXHu363RGmqwgP
	GOa524aeknZYjz6UcE8QkGdUkCD+b20=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-ZCmSdXiGM8qY15qQbad7IA-1; Mon, 17 Feb 2025 05:06:52 -0500
X-MC-Unique: ZCmSdXiGM8qY15qQbad7IA-1
X-Mimecast-MFC-AGG-ID: ZCmSdXiGM8qY15qQbad7IA_1739786811
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f338525e1so864065f8f.3
        for <linux-hardening@vger.kernel.org>; Mon, 17 Feb 2025 02:06:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739786811; x=1740391611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7uYWhEd1/c+mNMCq30U6Kc7sDjWCoVhIrgohc+6hGoc=;
        b=TBJ60pteRJ0SBm9IHtm2v6qv9q3Xc2RQWbxUOmo/qCIC7JDWdT1+ZebRQ2ett37ReI
         5LiaBEbzfkAFAUjVSgFJ+RNMH0A0dlqf62A9lFNIpH6BCODBzRODYkPNoTimF9Psv9Pt
         Mbk0POhA9DUkLPmePtASmchOQ8va7SR4uzKBkgGO5VJ8VqafQ66E+fG3MI85ohCNU7+V
         541pjxNZ+wanPmEwwE579PERtY9DoEL4ACQEOPYbaQR/gp/ytmQFKmxD4bJ2OnsEQlkb
         yoJDemco0hgLR2Pq/dzL3XITcMZJpAMWBupKnAacScK0DYlp6EqKptgdFWoAG1eAuUcN
         IlNA==
X-Forwarded-Encrypted: i=1; AJvYcCXZDEUyuNjhUlhkWJQII+GHsn9tZGVpGWq0xsqH/wjnBULATsP9ihZ4jzNszS45ffYIGyAuR0HYIugTlPpEPSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzayYG5cHudLg5zWRH65QvYZjhjJ6Z5Vvxig7R9gYcFe2HVFvPL
	D1XB6jk5O865ETgeGMkZNTPwCzM8IGDiHQng+yaEBTeUmhb1oWBtZlq0l22Dil2OOG+z7yBhyvm
	Q/KC2qNXq6cIPp9r8KgLGS3XdxkoeHqY2uDh9K5q7YMtp9Y9iQRCeuStMYLqhHbYeZA==
X-Gm-Gg: ASbGncsJiGOqLN/oVgOlmGSah70Q/5zqNZYXERbXoCQCQnq5i8YCWBTot7DONM4WATO
	GE9Dj8uAC2sfcuTbb3mpkIaKvoBqrdkGg00F9fGvO8s5jKGm94oos3ptqR17DBIvJpSW+qKiWVZ
	7wHTsqdaJ76J5kI49HpW7iWq7fUZLSEQHl2vaUJvT6t0iMn08y5QPFwCQ8/FEOa1RP9uf9JhI8P
	dWguxIwgvA/fc7y1DMw5xMlv0IERG6YWa3VhmXxZeyEP2iZ7jfRUMk26uSCg6csas+5fFSAXJ/q
	tJRzI9QyGPqnTBKmECl9o+8sZkNn6an870G2Xoqe1l8RwihR/dHj
X-Received: by 2002:a05:6000:4025:b0:38f:4176:7c25 with SMTP id ffacd0b85a97d-38f41768063mr2940025f8f.2.1739786810974;
        Mon, 17 Feb 2025 02:06:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF17aX5wN9RpvCFSTEz6ASI7aS8LQfB/Yvz3pfn6bQCqV1ymw293EC3qwrkdzNkvfNshhjdBA==
X-Received: by 2002:a05:6000:4025:b0:38f:4176:7c25 with SMTP id ffacd0b85a97d-38f41768063mr2939994f8f.2.1739786810613;
        Mon, 17 Feb 2025 02:06:50 -0800 (PST)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258dcc50sm12020780f8f.34.2025.02.17.02.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:06:49 -0800 (PST)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: adjust entries in FORTIFY_SOURCE and KERNEL HARDENING
Date: Mon, 17 Feb 2025 11:06:43 +0100
Message-ID: <20250217100643.20182-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: u3yUPpQbM2eYOGaY_et6EQkznBP71tvYT8l3_gVdQsQ_1739786811
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit db6fe4d61ece ("lib: Move KUnit tests into tests/ subdirectory") adds
a file entry to the non-existing file scripts/test_fortify.sh. Probably,
this entry intends to refer to ./lib/test_fortify/test_fortify.sh, though.
As that file is already covered by the entry lib/test_fortify/*, there is
no need for a separate file entry. So, drop the unnecessary file entry to
the test_fortify script.

Further, this commit misses to adjust the entry referring to
lib/usercopy_kunit.c, which is moved to lib/tests. So, also adjust that
file entry.

Fixes: db6fe4d61ece ("lib: Move KUnit tests into tests/ subdirectory")

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 53cf3cbf33c9..15632a34b740 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9070,7 +9070,6 @@ F:	include/linux/fortify-string.h
 F:	lib/test_fortify/*
 F:	lib/tests/fortify_kunit.c
 F:	lib/tests/memcpy_kunit.c
-F:	scripts/test_fortify.sh
 K:	\bunsafe_memcpy\b
 K:	\b__NO_FORTIFY\b
 
@@ -12613,7 +12612,7 @@ F:	arch/*/configs/hardening.config
 F:	include/linux/overflow.h
 F:	include/linux/randomize_kstack.h
 F:	kernel/configs/hardening.config
-F:	lib/usercopy_kunit.c
+F:	lib/tests/usercopy_kunit.c
 F:	mm/usercopy.c
 F:	security/Kconfig.hardening
 K:	\b(add|choose)_random_kstack_offset\b
-- 
2.48.1


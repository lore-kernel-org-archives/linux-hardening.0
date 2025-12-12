Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34657238C1F
	for <linux-hardening@vger.kernel.org>; Fri, 12 Dec 2025 13:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765546615; cv=none; b=hZiJBrDTn2B6ClaYoxPiEz5edWGdQcpf6WMctNrffBUe+XgZOGAlAV7SEnNfsW9G9y8H2x0PeNX4jxJMxflzf23oc9QMYPUP65qrqvzhc0amjvpP8fm/KuARYv3VN6BIZaXtZ0tH0IIF6CTlHrcKuLpaDXNNoyMzNankNfr4NdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765546615; c=relaxed/simple;
	bh=oUVNkrpx7zGOPrn75O3G+b0+ixWvCa6iP1b4lVbP63k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l+Tj+kcsT4acrchf6CkWYBGAsBkK6KDqaHDoaD207P6Ax1cZGvT4wroMuAQFeleHOCNv+d8mFynW9s2wNnwAzRg/uFDyygmXx3okpPg282wD4sj4JJh6Uko+2s+d39xEpQIcGX5n0Dkw4psfmX/gvl76Ny5E7uFb5QWxUEDu9QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRXUvjqN; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRXUvjqN"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29806bd47b5so7775375ad.3
        for <linux-hardening@vger.kernel.org>; Fri, 12 Dec 2025 05:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765546612; x=1766151412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4p8vNUMqVWCHBF8mIG+eTyca2IsDA2YUIUiwr2/tQxk=;
        b=gRXUvjqNmWIDzpe3G0pBsTX2oNNDo3JRjAd8t0/uFsm3d+m9xKMegR8wMFfFiz779S
         xhUZbGqqtRHNeIHtQbwujzTvFrG/ikVLzy2IOFMsdFHg9B9M2Qf+dizBpZATmy+NsF+S
         b9IERz5S0UAgcWaZSrIBPumjF9mKGYH7uOHpri7tpEEZ9p4bPWU8b9GtcBCHzLbRgrmQ
         YsMxa5aHhD2ibdqcsgyrG1jSiBFdLpu4gn5ysHCdIlmJROPViE9+XvvLYlLxxFefrRja
         PmNIbQJgPh0ODp4g7OvGoWzrwS2+wiG4lt95xxGWeFW2JGHJDuV+q42tZnCn0So7RxTH
         Vodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765546612; x=1766151412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4p8vNUMqVWCHBF8mIG+eTyca2IsDA2YUIUiwr2/tQxk=;
        b=Y0RMo7VUQOlMFsqs5tjt1K0TKFvM1pf0pVffbmWZm4QwII+q8KB20unUesglj+s9aP
         xt1qxp7xsCGQy5D1zXDmgqUvrjcm6KdLoG2Kp7DXBwmlOVMEKpVZLZFrjwNQCV1qABgA
         YFuT0D0HjDzBTFA81AmfaELI03vjyILplglmYqyQOjvDO0q4+J90nqyER0rC4qgeUCdl
         8nrIcuzl3T2H8+ykr0TD3p9L9/lDHk5YuvdmuuCj4jshtlYZ+BCQCx7GcUVYHTb4E9ao
         DPvJEiziCRYOT0C/OrV5JOoLifyUdm+wkPH9Ux3nM/faTHAqVTJaeKA3xWw2/8SkKyyn
         Suhw==
X-Forwarded-Encrypted: i=1; AJvYcCVXqrDLoIwN3T6IzbPNbDImuAA6RSEYYATfpp4Rf0NWtBFebuMhat0wDw1AsOtJEUwGiXlwXOSNJoePA9E8QNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAtKGGziJsXG+7Rxk15VBZI5UaJgfrXz4yJbGCP0cUCzEIQPPJ
	PTZcIaKmH/yTFViwEy14dhOn6K3nt2Tt6yFAJ3ZqlsmuUt1/mjKqykSR
X-Gm-Gg: AY/fxX620wC1U88w+JbNGAaC18fis5qbbrYhWw2BVu2gQsYyB0ih8gon8dkDjO0r755
	zENDi3T17FGYhbLh8aRbKO2t6xXmvOHvuo2tgb52x0+pp9urX4C+Qie+izXfObh0E53S6leCiSB
	+XmoUN+YxG9FOD3Pa0NG95v0x0qP3RrpgVhkwDIvbY8Da7nRQlUkJiF30SxkKFAtn9ptspbLBi2
	5b70JPOfCMPpb3lWg0wcJr/2WuSP+rOeLPVijrtw+5QNOSErzJ52s6lFsgpwegfflHVtXpRep66
	wtwJZIb14VWBzupdoV4kDsccsclpDW6qtuh42UnfzGGchiJFFjHcjxPzqBGDGVOwG8KP7vtbzPJ
	v1UmTMKKyi8k4MWb7YNMs1m3T7cfJsDBYEdSvOHwG1Wd5EzFU/tFMnQRkvnA5CqussiNAIkPXv2
	p8ZlS5QhLwXEuTa7ac
X-Google-Smtp-Source: AGHT+IG1e3GptgIXE0HC8FCQIABJ2seFG5lStgvWMjTuXllbX3tE9EnwHIyGGiVRWBCUk0c7vSQFcQ==
X-Received: by 2002:a17:902:f690:b0:298:46a9:df01 with SMTP id d9443c01a7336-29f23dd5307mr21047835ad.3.1765546612203;
        Fri, 12 Dec 2025 05:36:52 -0800 (PST)
Received: from LilGuy ([2409:40c2:1054:9e35:78d1:b643:53:d5d4])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29efb3657f0sm42544775ad.72.2025.12.12.05.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 05:36:51 -0800 (PST)
From: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
To: Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	ocfs2-devel@lists.linux.dev (open list:ORACLE CLUSTER FILESYSTEM 2 (OCFS2)),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Cc: skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>,
	syzbot+cf96bc82a588a27346a8@syzkaller.appspotmail.com
Subject: [PATCH] ocfs2: fix xattr array out-of-bounds in ocfs2_xa_remove_entry()
Date: Fri, 12 Dec 2025 19:06:31 +0000
Message-ID: <20251212190631.210139-1-swarajgaikwad1925@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzkaller reported an out-of-bounds access in ocfs2_xa_remove_entry(),
triggered when removing an xattr entry.

The root cause is that the original code decrements xh_count in-place using
le16_add_cpu() before reading the updated count value into a local variable.
However, due to the way the entry removal logic interacts with the array bounds
checking (enforced by __counted_by(xh_count)), the stale count during subsequent
operations leads to the out-of-bounds access during the removal process.
This patch fixes the issue by reading the current count first, computing the
decremented value locally, and then explicitly writing the updated count back to
xh_count at the end of the function. This ensures the array bounds are correctly
reflected throughout the entry removal without relying on in-place modification
timing.

The fix has been tested by reproducing the syzkaller crash report, which no longer
triggers after applying the patch.

Reported-by: syzbot+cf96bc82a588a27346a8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com./bug?extid=cf96bc82a588a27346a8
Signed-off-by: Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
---
 fs/ocfs2/xattr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index dc1761e84814..de99276d12f0 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -1941,8 +1941,7 @@ static void ocfs2_xa_remove_entry(struct ocfs2_xa_loc *loc)
 	ocfs2_xa_wipe_namevalue(loc);
 	loc->xl_entry = NULL;

-	le16_add_cpu(&xh->xh_count, -1);
-	count = le16_to_cpu(xh->xh_count);
+	count = le16_to_cpu(xh->xh_count) - 1;

 	/*
 	 * Only zero out the entry if there are more remaining.  This is
@@ -1957,6 +1956,8 @@ static void ocfs2_xa_remove_entry(struct ocfs2_xa_loc *loc)
 		memset(&xh->xh_entries[count], 0,
 		       sizeof(struct ocfs2_xattr_entry));
 	}
+
+	xh->xh_count = cpu_to_le16(count);
 }

 /*

base-commit: c2f2b01b74be8b40a2173372bcd770723f87e7b2
--
2.52.0


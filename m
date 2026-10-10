Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5DF39768D
	for <linux-hardening@vger.kernel.org>; Sat, 10 Oct 2026 16:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791650703; cv=none; b=iG1Bionjvf98estul6R+6jntCVKfChdegOc5canjdrcC9lsai2M1J7fZARiwCEKs64EpGTALNBcW2MvqCSDW/SyHADzteLXRwFrs0cVJz2gT+hwIis6dDFaJLpwDArsz8JA4ObVFXpty97CrdVPDDhA2VH2Ur658SmVWSRfHi5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791650703; c=relaxed/simple;
	bh=4mXkg6pjMpHSRcU3f83JQMaC6JjhCSK2DlDg91mL8SU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ijeAyj4hBkou/+xxISXXDg2blj1G/z+ZyG9S8TMlUBVpTjD8XPgZR6+7K/EI4dZGwz+r8z8oEH5+ksLls9CuIjCESG+1FmaVh+jI4du0dX1yuErtFJu9DhGNUdhrpl/nwyCE05OsS0umL+sQg5LNaWBGJUbQYqvb596LZe3dbuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2xMUeTt; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2xMUeTt"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cd3310348d2so1092636a12.1
        for <linux-hardening@vger.kernel.org>; Sat, 10 Oct 2026 09:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791650702; x=1792255502; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MavqeFwiz7qivrzrIW1HjpN4bRTfbcocClc6dsjot50=;
        b=c2xMUeTtIibmOnn+IG6lUZ8QmNOv4TENWtdqbSvDwJTZYFTe+AJsf2rX9it6GuzIZf
         WsIBPVUNDGO0ttZZlJgpziebRl7vF7b33HynnW8WfeoJ66DB8yRjBN4DrjumBBl4Trwo
         WaRaGKUl5TUIXbSdqV3PPHcwPdgQ+7mTrNxfDTBifV1oV/OnjYPElDaaLYG1FS1+twqu
         onk2gBu3dP4YVOvPBQ0mo09elGOtbh/UZI99bDi1PR22B6vtfzrZBcac5Vg5633Ty9HU
         lxRMCBQYrML7hvsBzkrBxbric1rUzt0zxGbxxFzpuBBv2eCGtLSkTWkwPFWfhGlkwyNm
         qOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791650702; x=1792255502;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MavqeFwiz7qivrzrIW1HjpN4bRTfbcocClc6dsjot50=;
        b=BtWp9k1m7MkvJJoxuTkOnyiNpn04bTIEdunP1H+2ZWkmuSG7DqNaWxLRTQ+Vfg30St
         6Slad0JvV2OzI3tLvtiqfb1kMx2PiVjN/SNlwwbPahhiUU65pH0QZXWBSVru2vSZ/8BD
         ZycaP7K542kcXZKzg8YbPP1g/1cRnrIKKKcun3ywzwYZ0dhUutz+B8En2WxUL/oo1AKY
         6GexHKQfhoojrsjzCcKPdXPN+urkrRHcDlcveEz+qEXVFXKQAfnE5jZIAavvr6XpsSkp
         9MxUelzJAAPwwRqJ8490dME8OuzrvBwJicFUy3YrSBF8H8xCWDrkK+8TUJeB4Mq7ObCD
         z1gA==
X-Forwarded-Encrypted: i=1; AKwUvBwbTgAtLabug11AqRaMd/Bcfi7E/2Qu+VHEnLXfWbkL4pWTwSgBxLOmUp3wuqx7uR0axwC5F8Fz34EkOzsSlt8=@vger.kernel.org
X-Gm-Message-State: AFq9FYL5Qtzy0eKq31CDlLO5iyTjutCNkYETD4wfYu4c3CkjLJctRc0P
	Fw7bMiLWcfzsf60yzA8U3xfuHnQaSWDnt7yXDZJxAWaO3QcNGAKVFENx
X-Gm-Gg: AYBFou1T3UcslEfaT7mjb9G+DPPoOTv2MSZAOwEEzMKxEBFBIGgZMt/p/DvXvQ8LmQ4
	ybCCG1Hux1ClVx7tdxb+WI/UWWQ+uB2kr8b5qM+2kw4qY+r/HEho9nPRFcx/BbVkUoF3+MHODiN
	cQc9RWvN5xVR796wVtANtMog76B6Pu0+esTXMlXkyZx8qYAOonIVpY0yIFDSvWX6KUOfdW3ejKb
	BfGKRTFba9JW0M0GdWfAP8/eG0FdhMliN0v4MEcLNyHVPFqbGN+wGaSnx48sV0yYEpHas7v06Gt
	9lHwOdPgj+V/XW8v/IN0I9nzXBTgdPBdyIwbIg8w/O/KxOjcLiCh8VsUacoVlg3Q3IOMBAPKk6N
	Otz7QaJ6U68JfjUU+kIED9t5NA3dJLtVhc2zJBi5PaakrjFKEpV0ynYeBiJxu5xnozfG9lqnCFJ
	oYLyRQXzIPYe4Hc5E5jth5niCc2b2m+eBjP8cY2MsIgswNZu+lIPQGFNdDG+1eUZihnsiyfg==
X-Received: by 2002:a17:90a:d006:b0:3a0:c31d:80c with SMTP id 98e67ed59e1d1-3ab3a953313mr2454468a91.9.1791650701717;
        Sat, 10 Oct 2026 09:45:01 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac1:7a80:50::3cf:2d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm9096896a91.4.2026.10.10.09.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 09:44:58 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Tingmao Wang <m@maowtm.org>
Cc: linux-security-module@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev,
	syzbot+a0eecb22de4d821a9e5d@syzkaller.appspotmail.com
Subject: [PATCH] landlock: Drop __counted_by from landlock_domain.layers
Date: Sat, 10 Oct 2026 23:44:49 +0700
Message-ID: <20261010164450.194439-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6ac91e98.bbc4c7f9.15faa7.0023.GAE@google.com>
References: <6ac91e98.bbc4c7f9.15faa7.0023.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

With clang 22 and CONFIG_FORTIFY_SOURCE, the second
landlock_restrict_self() call hits a bogus fortify report in
inherit_ruleset():

  memcpy: detected buffer overflow: 16 byte read of buffer size 0
  Call Trace:
   __fortify_panic
   landlock_merge_ruleset+0xc46/0xc90
   __se_sys_landlock_restrict_self+0x2bc/0xd40

layers[] lives in an anonymous struct inside the anonymous union
that overlays work_free.  For such a flexible array, clang computes the
address of the __counted_by counter as the start of the array instead of
&num_layers.  The bound is then read from layers[0], i.e. from
the first layer's configuration, which is not a count.  The same layout
crashes clang itself in a standalone test.

The annotation was added as documentation, so drop it rather than
restructure the union.  Keep the information in the member comment.

Reported-by: syzbot+a0eecb22de4d821a9e5d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a0eecb22de4d821a9e5d
Fixes: bd3a19800dd1 ("landlock: Add counted_by in landlock_domain")
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
Reproduced with clang 22.1.8 and FORTIFY_SOURCE on mic/next (64b9e6eff524):
the second landlock_restrict_self() hits the report, while 16 nested
restricts run clean with this patch.  Mickaël, if you prefer to just drop
bd3a19800dd1 from next, that works as well.
 security/landlock/domain.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 60e8eb2d6ac2..4bf1555a4349 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -246,8 +246,12 @@ struct landlock_domain {
 			 * properly handle merged rulesets without overlapping
 			 * access rights.  These layers are set once and never
 			 * changed for the lifetime of the domain.
+			 *
+			 * Not annotated with __counted_by(@num_layers): clang
+			 * miscomputes the counter address for a FAM nested in an
+			 * anonymous struct within a union, which trips FORTIFY.
 			 */
-			struct layer_config layers[] __counted_by(num_layers);
+			struct layer_config layers[];
 		};
 	};
 };
-- 
2.43.0


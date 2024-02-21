Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A098947A62
	for <linux-hardening@vger.kernel.org>; Wed, 21 Feb 2024 09:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507725; cv=none; b=Hbtf7f50lZBDGE3DGy2gILMG97k357qVmG/HFtFoJKZWVykdcyKOuDilIwmYi2udQwGoMH1c+PmAezl6Fo0qLYvIKJa9xqWnaclzYcy+PPIJFumKAyrkBkGZUUm0vUNYJtBOtXYGjWjK1dr3ajPrYH4OrQ2bkidJI/uye4VZf2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507725; c=relaxed/simple;
	bh=MALY8PY87om1B5rM9PQyZB962vp0AzyA5B9YGRQAQS4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NdTpx34DrchJ8Bi2Wu96GQBFc8mN3LdAwN27BpKNIH5kdS2Sth9jRmrlzP56D9PA8t2+DQ32dfjR2tFCKPLuHODUMZHH/sTJRGxoyJEVbSNouiAQHhjbB3XcXjYAWrkbtDbH7hhjN52COH0SzQ105EXPTkTDT1sTdr2vyNZpTJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZtDnRb1H; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZtDnRb1H"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dced704f17cso2525608276.1
        for <linux-hardening@vger.kernel.org>; Wed, 21 Feb 2024 01:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708507722; x=1709112522; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UtSX1a4twDclpP0XCHq3xRlg28EKI7v3CFBboD2ALTI=;
        b=ZtDnRb1HzJUvAH/0oR/bwjouHiGv5Hx12Z2jxcyrZDvjJX98lm29rJnvTIR3l4ObQM
         Ov3OCZO5XOKws6sxRzWJDcWAvUjveniIONlT2qOQU27aN9W5ygjKa9/Dbdy5zxc1xQrN
         IxNG2r44hsCgnlpuc8kXITwp6cnQeAetTruqquLTRkOSJPERNBjayKovt+WYmuZfmu/N
         XDYPli2ynlc65GjfIyiP0X/AUvLqv3K3gKJiGwul6r8aRt8FUtd322nyYEHLGyQ2O2FR
         XoBITuavIT1fSwdX+FNatnoLoYVjFKExpvElpj+OXcfSasXJJVlEAbboVA+Ys4hQDguq
         qTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708507722; x=1709112522;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UtSX1a4twDclpP0XCHq3xRlg28EKI7v3CFBboD2ALTI=;
        b=EvxwaWhY4Hu+F72Bl2fp0ZW7kGIXTJ4mzcp3OePkCXeDLPzbsFLttqrkk1lBYZLJN6
         MyM3HEOGxNbgLyDazOCqDTsRZtZ4lNyt+nd6F3UaXNPZhKUjgxZ+fNH7GThQvoCIrka5
         QlfcoO80+M5dFp4HCMvnqJcQVvStVQ9kg/8IznC18Jjo+7gzGjCIY18jdnAW+7f6hZLj
         Zuz/2+579Ek2ddGtq7mMIoAM5lwzUUrcHuBS6DVirZJKRdUC184KQAAP47Kf/wG3K5aO
         3MD3NRLtNiqxbqPLMlf6gQeT03gqmMuVHzbVq+o7rCYXBHITe19aWvdQQUwsKk9NuvVD
         4gyA==
X-Forwarded-Encrypted: i=1; AJvYcCXS2EPwOTyF2ZLtzgWdjgslkgzkk69btVp61OR1MrJ1ALMDGwzTakP/gf++s1rJdTK4LLOOpUNmY9U6FW/PIekte7KZCMdh7UpUihAVpvpq
X-Gm-Message-State: AOJu0Yxy/OqvLbmcqXuaZLKPoupTy6o4Vi/MQunX5wvAiUbiV5tD6L1X
	uJgTNqsYTRo836ZTs6uZimwEREKhUq6IyiABy89UUKRnF+y96WUVVcvlkwdq8zsSl7dj6HFdOsM
	O2NjmH2Wp/g==
X-Google-Smtp-Source: AGHT+IE+u4BHsnTY4zBV9uwlLnSALfH2VACViqUl+6ZdsI4Ll1wRpv0qUeWfBww+/YNGvG/0sUR+LBCAIAUp6Q==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6902:4ce:b0:dc7:865b:22c6 with SMTP
 id v14-20020a05690204ce00b00dc7865b22c6mr618682ybs.8.1708507721736; Wed, 21
 Feb 2024 01:28:41 -0800 (PST)
Date: Wed, 21 Feb 2024 17:27:22 +0800
In-Reply-To: <20240221092728.1281499-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221092728.1281499-1-davidgow@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221092728.1281499-10-davidgow@google.com>
Subject: [PATCH 9/9] kunit: Annotate _MSG assertion variants with gnu printf specifiers
From: David Gow <davidgow@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Guenter Roeck <linux@roeck-us.net>, Rae Moar <rmoar@google.com>, 
	Matthew Auld <matthew.auld@intel.com>, 
	Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Kees Cook <keescook@chromium.org>, 
	"=?UTF-8?q?Ma=C3=ADra=20Canal?=" <mcanal@igalia.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Matthew Brost <matthew.brost@intel.com>, Willem de Bruijn <willemb@google.com>, 
	Florian Westphal <fw@strlen.de>, Cassio Neri <cassio.neri@gmail.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, Arthur Grillo <arthur.grillo@usp.br>
Cc: David Gow <davidgow@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Daniel Latypov <dlatypov@google.com>, Stephen Boyd <sboyd@kernel.org>, David Airlie <airlied@gmail.com>, 
	Maxime Ripard <mripard@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	intel-xe@lists.freedesktop.org, linux-rtc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

KUnit's assertion macros have variants which accept a printf format
string, to allow tests to specify a more detailed message on failure.
These (and the related KUNIT_FAIL() macro) ultimately wrap the
__kunit_do_failed_assertion() function, which accepted a printf format
specifier, but did not have the __printf attribute, so gcc couldn't warn
on incorrect agruments.

It turns out there were quite a few tests with such incorrect arguments.

Add the __printf() specifier now that we've fixed these errors, to
prevent them from recurring.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: David Gow <davidgow@google.com>
---
 include/kunit/test.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index fcb4a4940ace..61637ef32302 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -579,12 +579,12 @@ void __printf(2, 3) kunit_log_append(struct string_stream *log, const char *fmt,
 
 void __noreturn __kunit_abort(struct kunit *test);
 
-void __kunit_do_failed_assertion(struct kunit *test,
-			       const struct kunit_loc *loc,
-			       enum kunit_assert_type type,
-			       const struct kunit_assert *assert,
-			       assert_format_t assert_format,
-			       const char *fmt, ...);
+void __printf(6, 7) __kunit_do_failed_assertion(struct kunit *test,
+						const struct kunit_loc *loc,
+						enum kunit_assert_type type,
+						const struct kunit_assert *assert,
+						assert_format_t assert_format,
+						const char *fmt, ...);
 
 #define _KUNIT_FAILED(test, assert_type, assert_class, assert_format, INITIALIZER, fmt, ...) do { \
 	static const struct kunit_loc __loc = KUNIT_CURRENT_LOC;	       \
-- 
2.44.0.rc0.258.g7320e95886-goog


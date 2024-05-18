Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B4E28373
	for <linux-hardening@vger.kernel.org>; Sat, 18 May 2024 18:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716057627; cv=none; b=e+y0omyos9Ni/vFT/ZQM+/j5RmyKS3oHBntcNzKVCUYP7KQ38cBWqIO0WRM88CMmkwmG5nOJNUj3+s3jHiaRZSR74e/EVjx2jUVljnFqep9zkM8G9mxJFKxv60mAu4vVqklmMOiCp7HI7zZrwzEmY0b0wLhn+NCLYe+0bgosjqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716057627; c=relaxed/simple;
	bh=k+ng9wbRlHf17xens6mhVDQOVRgsDX7w2D+5OLnXe/U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iXAgxwsw71aF0cmnQfWH1VkVQWf68X0mRMn1NfdlDVRArj1sLoCaAr82L1rmfcqxY9gDx2KtysBLDK59KtUeV4/4lpzOxQGumYfkq19l1n6bIBHL8ToWm5qV0yyLBrZePRFBXTDWB+zUx61WU1vERyBOOzYknlUqR0SNzRQqc/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YQu53FAT; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YQu53FAT"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ecc23e6c9dso39720405ad.2
        for <linux-hardening@vger.kernel.org>; Sat, 18 May 2024 11:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716057626; x=1716662426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i9upi3rN8BKzsNW7vROl/Uoxe3wcuLRhsoKYe8pqaKQ=;
        b=YQu53FAT3nLHbcZLWiC3m/fAwmrf8Wit+32eDsYkcNcBnwRsMbog/nHyNiv2e0aUZb
         UeGvtQYeLORL8m8B+9Aev7V23XBaNmK5jLwEnaSpfmGlqrorZDz1bPLAOXO2kThsJI0N
         idvP/Pbt9/xQtz8e0s8Sc4ql6AXEV/jhmsCLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716057626; x=1716662426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i9upi3rN8BKzsNW7vROl/Uoxe3wcuLRhsoKYe8pqaKQ=;
        b=Ffi+XVrtKDjXI3bUJeqabMIh/RSMIeAy0lLtgorRIPc1ziLhfrXDsE3ozePeSBrW7N
         qnyLBO/IiG/Nu2jb2k0VU1LjrWVgXlnZZ9fSWTO0pbg1kg5WcUsl0gCscGyvF+fgKtOx
         HDLTNTEEBpF9TBBJmH9LkPNP4qL9CaBrP+XKwiFVMOyEHH4s9Mfi7+PG6WX9eVjeVeNm
         uwL8mqZ4j2mcc3mRpWDw5d/Eq6ss2USM9npNTWbQ4bRXy0L5El0K/g38fHGg76ICq9LK
         wJu9QHEeCGvN2ucwBUBuowa9wn3L3jkBn5HcYGlarzZJs8UbDAybjf3V3btFRvI/oOND
         SFKA==
X-Gm-Message-State: AOJu0YyNH8wtk1yV8whZ0ifKXaUc2luO7WdgsSfmchKjbAGc6N2RAyDu
	A5N6cKo00q5hzJrHXVfbCscs2gqts00GYjRYvtbm8Kzp3UayYURhRyf8RlCrIYnow3vkNmV+ERw
	=
X-Google-Smtp-Source: AGHT+IFuxNtBeIlF7fvjXHDHzCSSJToJGKljZAgnFvVNCJ2Abmnr4AI+2HASVt+rdE1qJz+MVF5s6Q==
X-Received: by 2002:a17:902:e848:b0:1f2:f954:d6a3 with SMTP id d9443c01a7336-1f2f954da5bmr324415ad.5.1716057625812;
        Sat, 18 May 2024 11:40:25 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad61c7sm177009135ad.68.2024.05.18.11.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 11:40:25 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kunit/fortify: Fix memcmp() test to be amplitude agnostic
Date: Sat, 18 May 2024 11:40:23 -0700
Message-Id: <20240518184020.work.604-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1081; i=keescook@chromium.org;
 h=from:subject:message-id; bh=k+ng9wbRlHf17xens6mhVDQOVRgsDX7w2D+5OLnXe/U=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmSPYXEB4BYO+wu/L5FgksDzyElF61gFBnWFH4h
 6QXCGgfte6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZkj2FwAKCRCJcvTf3G3A
 JpOKD/96VbRsJOyJVRopWjNo7ozzJWVXD1VR3R0yQNoWXOBc99IzaAlIBYFPDcXeu29ehMzMfTo
 dukapW35fOP9PyWTfZvafUf+8WdCeseMc+JyWjr4EDT/1/6zl+80FUrxFgIKH0G/SDbhBz1SLAk
 /4m3KeQ2NkycOvtRjcg1Rhd1DsyYPZ63LMgEGLWjUfCspfwDFuCgIwcmQhbufyWCguZB1XeuRzZ
 10P8FnhIw/n3tYhAYSbgO8tBEyxcxWOxFRov5YIvZfAeufbJoVls5lpxO/tAoS7Eo6/jSPEM4yI
 789unphFYixgC3GtAZDLa3HXV39u1OwhysY2KVZeR/rQhKivKf0wqZ/zKI0d+nCMI4RhftIK+9h
 jX4Em1sseHOItcsIziwJDBFlu/MToSAP/3Zh4JeZ29i+uxj4H0HDgo0cfvh/BnKSIgYX/vo8uFD
 IAaNmAB2wersufzlB1ppMY3BBu6G8aQYOU5NR/yHOBMvfXtTtv/Tt3dpoZ7ODCUeNuM30P+8tfA
 FSEKEm7holwG8gSjGuQCQIVWDHe/NMmQ66gLNxbjr/8qSsfFHAZ6IOnjnrm8V5G4EMoZ7qqIecZ
 77QHSfhDFeNQjRSmigMItL/rhcNTjz/YlcO46iDV8A/oH+5D4Fqh64472UacFpuqK1/nd14eYLB
 bKSeLG7 ChI4Bfzg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When memcmp() returns a non-zero value, only the signed bit has any
meaning. The actual value may differ between implementations.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://github.com/ClangBuiltLinux/linux/issues/2025
Tested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: linux-hardening@vger.kernel.org
---
 lib/fortify_kunit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/fortify_kunit.c b/lib/fortify_kunit.c
index d2377e00caab..39da5b3bc649 100644
--- a/lib/fortify_kunit.c
+++ b/lib/fortify_kunit.c
@@ -990,7 +990,7 @@ static void fortify_test_memcmp(struct kunit *test)
 	KUNIT_ASSERT_EQ(test, memcmp(one, two, one_len), 0);
 	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
 	/* Still in bounds, but no longer matching. */
-	KUNIT_ASSERT_EQ(test, memcmp(one, two, one_len + 1), -32);
+	KUNIT_ASSERT_LT(test, memcmp(one, two, one_len + 1), 0);
 	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);
 
 	/* Catch too-large ranges. */
-- 
2.34.1


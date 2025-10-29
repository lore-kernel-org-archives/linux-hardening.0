Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0951232AAD6
	for <linux-hardening@vger.kernel.org>; Wed, 29 Oct 2025 11:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761736863; cv=none; b=JR9Y6Z8IpJNuTiv4rH/MvUApqrynDr0Jcn7j2eIZodoFJbtpE4bm3vLEGkFhzmbUlcKG9dmWiQEHRjbk8VpOpMQRCmoggkCerZnIlP31zySCPOf3EjzakuCGBw+m15mVffnlWZ5RHBgyCxI2P2k45Wt0byBwR8yZBzy7Pe79gBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761736863; c=relaxed/simple;
	bh=xqwlDgeQ89A6k5YIQo0IueQM8jBP+yv/zbt5OFOnI+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uujnec5xz+8qEA18Xr5K2+ftzrExBLUKFSDMgMSqaK0MklqHLgBEa3isH5D0OXp834Aglo3T3ofGLWUF2XrT/AF5MUrddkhqQDvpCLubUoB2HHlNRotC02etkeqPCAFyXAX+6vYkmVduY08R/Ulygr/+eKepwV/Dp4Ga24v+EqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=A6tMZHJR; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="A6tMZHJR"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3ee130237a8so4695587f8f.0
        for <linux-hardening@vger.kernel.org>; Wed, 29 Oct 2025 04:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761736859; x=1762341659; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KNfVvIhx701ah8nru3+V19npf0IYFyMM9HJ8zi25jFQ=;
        b=A6tMZHJRIBK7+qW2yrMhMcL9T9fZ7HjK9FOaP9Oe7AEYhJijahNVf8EDbR2NMuAh+h
         xrvaYlaW2AQBpeJpyPWSjRq8KB15ilyuXK2SzB8I9pYPhD7qSU2oYSgn3kcEbv6L69YV
         z+RvU4Ymc3rQGS8rwTpcYnG2XsKlpDI+9E1bb6knvCe0si+Cl09HxyC/IsCPMFR7yeg4
         QdXlxsOU2uzAATT2CaOneRjCM1NKtimERRsYZImR8ofCWQwsXX8uFLGO17ShMqQ4oCUP
         WJLseUDqDxItU3k4aHNxoMO/0Pkqv2QV2TW1bFPMAOWS8rjkBYDXIv3sXYb8XAL79zWk
         oKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761736859; x=1762341659;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KNfVvIhx701ah8nru3+V19npf0IYFyMM9HJ8zi25jFQ=;
        b=MIZ3ZUguGcPWJX6AuZKtxNF/79iVfw+3ZlAbU411vU8z/aElycPpXY6vr7cPnnBJcs
         ByG3UsmBj0hW+XatHWwcr5Uwj8ZJiTEaKAiAk+ULXQ8/P2BTzg/j4uB4M8u6UwJkYbov
         8B2pDJ0/1AKaXyF/Ix6WE13E1fw6eFBUkDSGvNnli6yezUBMxXRJnfB8LFGG57wFBdFQ
         sN7RuWaNe/4WqEkaB5O8aAhL/fnXXVADx5pJ6N7vyvUIoMI+OERzBS+lw2Q7rldU1MZx
         KNGmSqgYseNEkCOhRq7Td2HeMcEazL1VthBfhRJ7rGm26QOXVH/pw3CwCoAbvmGMdbeT
         CKwA==
X-Gm-Message-State: AOJu0YyKiNPMD5jRcOz6NYUfO9XXm9TXRZDOCYf2FfHQ0JQW0XjJuY+Q
	OzYp/gnWbwM2DI0PfIDxcMm0pD5h17hjZzPveuXqnUGXeaNu5Z8xu1n8RC397U8tUpg=
X-Gm-Gg: ASbGncu1qcmSSLymG7LA2aC3rrqw+33ap9Gstl9f0lwVm5kOpBWuDlU1n8Rg3gRNtcT
	rjBSpmd5GQ1EKNINq/VOnOGvnpV2OFhkBNkwT0K4mW+0ywB3iKzviT4yXFNMFrGOcuGdT0tGG0K
	f1wL98ESoXdmFbjSgRMUlUc8iEgAW4uT/m1WSPfv9VRsMZmlRsiL1HKLlTxZBWgDyx0E4hgbgi2
	wRsmJ/HSXmyf42Xj7EQUdP+JUQ71JS83LgcoxsbXpMNtSrihCfTL/89U7c67a8Mo52Elil4WQVT
	SIGo4Tip7JZuw0fs7MyBeyo7Et66wfGb+5mdqmoPj4XRAjeFZ5E4tz6F169PN0rtoYVPnZna2dx
	vXO7OSw8oRV1lBAeRVgROHuqw9EqMe6LsT8ySZvzogTW7/qJG7f++w9YXhdKKxyMgS68pDA==
X-Google-Smtp-Source: AGHT+IGkeePD1kd3vgQlhSJySty97Jor3EHVR/WRpsuK6mSgnn8nhqA+ccxY4OWM/uotcxoBrCX6kw==
X-Received: by 2002:a05:6000:2889:b0:427:5e3:7d74 with SMTP id ffacd0b85a97d-429aef846bdmr1672292f8f.23.1761736859166;
        Wed, 29 Oct 2025 04:20:59 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:69f2:5f2d:9ffc:a805])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df682sm25657486f8f.43.2025.10.29.04.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 04:20:58 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 29 Oct 2025 12:20:37 +0100
Subject: [PATCH v3 01/10] string: provide strends()
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-gpio-shared-v3-1-71c568acf47c@linaro.org>
References: <20251029-gpio-shared-v3-0-71c568acf47c@linaro.org>
In-Reply-To: <20251029-gpio-shared-v3-0-71c568acf47c@linaro.org>
To: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Alexey Klimov <alexey.klimov@linaro.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2470;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=O5IzffKw+D234c9Cj7vSqj3rWLQD81BDCjLEL9uRAyE=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBpAfiV6DK3udvEgE5VJ4HmVhvlb/raHRjuJQXuS
 dZVJrSuRW2JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaQH4lQAKCRARpy6gFHHX
 cjqID/4+HBzt3N2Gpg3GKc73QKGJTsVH1n4jKs7wsCfKCqFZ7OgFKsj8f3jXrcl7+PFGCI/qE3P
 NEuI/XbY11Pp9NXJtuZvK/4kQYuFmMvpKd1KeQWyqDuh4vAjMRTVLckmT9nCjXeSMxm0vSI3YI4
 06l68Ph5qhGW2O0orSOQ+3VtnrkFZo+jhomLSEPLxT0nZGf7Q+L2LFBTyWMn+OjW8vQIUmU7wJS
 AIrnaet3+OfcF9IIRXq0gn7EvkJQu+RmAA/1KT/xLsFLh+EzzYXm6HZhVWrsBzzs6QMVrEjzdYm
 AmtxEqtZPWIMEJdrW3mzzQ3vhC/GEe0zce621cK0/vhIt2AS0Mng690EtRH7sxWlxwRZ71QH7cB
 cXfCEJHLNfDVzyd8NK+mSjehpzzlNcnvDIfWrjwIQukYXlk/bh4ZrdS0Q2q65jKhmog9Arj+bXl
 PLpSe+TGkCXrlb4wkIA0LOm10tqd4PbNwazFwFZB7EIrbEJbDdOy30p/gdy8KmHTzp7USMLJimy
 BxLKVJj8DcagEWFId98URp1Ckws2hpH9vwLm6jJrMFSQrYaVM5ccCFDwscpOxDXOxuXIZeoBZ1N
 Bs3Tj8B3kE7gvGTYPLtsmX2qnfYx1A/0iUmbFy/WiEiBHpjGEyc4o5ETDEwWJvxQ1cxYD/XwDZ/
 a8DRV8ViLKm5GZA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Implement a function for checking if a string ends with a different
string and add its kunit test cases.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 include/linux/string.h   | 18 ++++++++++++++++++
 lib/tests/string_kunit.c | 13 +++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index fdd3442c6bcbd786e177b6e87358e1065a0ffafc..929d05d1247c76eb9011fe34250b487834b2d3c9 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -562,4 +562,22 @@ static inline bool strstarts(const char *str, const char *prefix)
 	return strncmp(str, prefix, strlen(prefix)) == 0;
 }
 
+/**
+ * strends - Check if a string ends with another string.
+ * @str - NULL-terminated string to check against @suffix
+ * @suffix - NULL-terminated string defining the suffix to look for in @str
+ *
+ * Returns:
+ * True if @str ends with @suffix. False in all other cases.
+ */
+static inline bool strends(const char *str, const char *suffix)
+{
+	unsigned int str_len = strlen(str), suffix_len = strlen(suffix);
+
+	if (str_len < suffix_len)
+		return false;
+
+	return !(strcmp(str + str_len - suffix_len, suffix));
+}
+
 #endif /* _LINUX_STRING_H_ */
diff --git a/lib/tests/string_kunit.c b/lib/tests/string_kunit.c
index 0ed7448a26d3aa0fe9e2a6a894d4c49c2c0b86e0..f9a8e557ba7734c9848d58ff986407d8000f52ee 100644
--- a/lib/tests/string_kunit.c
+++ b/lib/tests/string_kunit.c
@@ -602,6 +602,18 @@ static void string_test_memtostr(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, dest[7], '\0');
 }
 
+static void string_test_strends(struct kunit *test)
+{
+	KUNIT_EXPECT_TRUE(test, strends("foo-bar", "bar"));
+	KUNIT_EXPECT_TRUE(test, strends("foo-bar", "-bar"));
+	KUNIT_EXPECT_TRUE(test, strends("foobar", "foobar"));
+	KUNIT_EXPECT_TRUE(test, strends("foobar", ""));
+	KUNIT_EXPECT_FALSE(test, strends("bar", "foobar"));
+	KUNIT_EXPECT_FALSE(test, strends("", "foo"));
+	KUNIT_EXPECT_FALSE(test, strends("foobar", "ba"));
+	KUNIT_EXPECT_TRUE(test, strends("", ""));
+}
+
 static struct kunit_case string_test_cases[] = {
 	KUNIT_CASE(string_test_memset16),
 	KUNIT_CASE(string_test_memset32),
@@ -623,6 +635,7 @@ static struct kunit_case string_test_cases[] = {
 	KUNIT_CASE(string_test_strlcat),
 	KUNIT_CASE(string_test_strtomem),
 	KUNIT_CASE(string_test_memtostr),
+	KUNIT_CASE(string_test_strends),
 	{}
 };
 

-- 
2.48.1


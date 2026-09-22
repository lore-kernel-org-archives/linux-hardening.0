Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4375C23BCED
	for <linux-hardening@vger.kernel.org>; Tue, 22 Sep 2026 22:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790115007; cv=none; b=e+BuhYvz/DvP2M1c7UPoFm4TzduHwaZolK9QlyUW8L8lQtV5wrD+HHZWKOv8NEgZyJANMqvJzlmtp5BXw+1J8779DQs5raqvmaLTpg5N2G2VE8zrsjznP4NoML7jKeYlpamq23m2pZauaJwueUPHfn715IzCZpWHVhVIbA53jQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790115007; c=relaxed/simple;
	bh=ez6IjVz1RI/L1fCWYZYoXXXQ0XI9Qbd928iUK8xMI1Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=l3w52M9+7TEuQsxlsRnKw7UVi+otsfyquw/FmYvr1UFfFCt2UwMgbEAiM0N7IucF5FMwRmIeP2urbkG4SLjaJDL04f7K1uNI24T01DkvE5Pf0L/qHG/ipayeRF0VNhXxDEKZkX+p044KwTGhRq2s5NhxOE7Ode9RmSNkf2Gx9rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L13afg3S; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L13afg3S"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39e25a5f6e8so384042a91.0
        for <linux-hardening@vger.kernel.org>; Tue, 22 Sep 2026 15:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790114994; x=1790719794; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KStyCSuaz3JtzFB2fu+E5KRM99Ww/CsJLkB3+qyDWQQ=;
        b=L13afg3SJ8OAsLJU4yUbZ2cLRTNRhLsm4SF7IAlw5qEvtKqwJiL8Tx5MengxIA/wTK
         GjyqlaZ6bpVkTnTdoGVTLKsenaazIt+Y746Pk+Id0kEfYlz+LTPzVjgMyajLusIgc9uZ
         r6LB30kexihn4vyRir/7JL4RH2X8sA0OocD6cDYgy0GYYuzXDRvbEiacTYKfn87iXkzq
         nLouAVmJq/zdiAo95Njw41J2szM2kucQu23BhSIgbZ+M/BNaVIGc2SvSujgO4Ber+MM0
         tRZWjMNmmTHy2NvUMfo3q5GEGdydUCbGIAyFxu6ojdu3/oy8ZGtbP8O++SsWbCIIrWNG
         pC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790114994; x=1790719794;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KStyCSuaz3JtzFB2fu+E5KRM99Ww/CsJLkB3+qyDWQQ=;
        b=BD8hZZmauSpzif5SmVZslvsd2xVkGesxfmDfVQP/7zg6kPzn1ujIbPekVmPvOX7tmy
         KEMPIwbmI0rFULzVK6RX7liMfokMMxqRSOfOEivSNQl+GW/AjHZzCwLZO0fAGF1WioO9
         ryDzhAfd93oeTFS5UcrzO7zEmthm4Wwv8vx36YiJZJA/x1ug3Ttkgw4vdOY3fD+rdLlX
         LavIAuqP6IvmUabd1H2Gl7szGKtzGhsxu8lu1BSrUT52petmnEUzOBBnCoRYDNEYjEmo
         zd+GVLHykLMLkpG13gakhQ5oOs4geRoBxjFmOBTj0CNR+Uvh52Iv9I1z5fDZ+ad+y97U
         7I/g==
X-Forwarded-Encrypted: i=1; AKwUvByt/vJ75cSDV30nAbidEYgfDQM6IhssjWIYAiwMIm8GUp9TIYHW0jyAbvOMem1lNIYHhXhL4Pi+dkwfXLmBshY=@vger.kernel.org
X-Gm-Message-State: AFuF++kpUUH5U3X2YkjkEjOOeTHmv3cDm/EMqYPZn/fucas93YCQHbMZ
	iHLxU1S5/KYVhUZof6Eh8oENP0kFF1TGZHvDqlNG7FvTfUbJ5t7/KoDk40IXxl58c6dT+nnwxmv
	I
X-Received: from pgbcn9.prod.google.com ([2002:a05:6a02:a89:b0:cbe:e432:1cc2])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3d8e:b0:38e:fea2:df53
 with SMTP id 98e67ed59e1d1-3a07e5adc58mr635171a91.4.1790114994291; Tue, 22
 Sep 2026 15:09:54 -0700 (PDT)
Date: Tue, 22 Sep 2026 22:09:50 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922220950.2267270-1-morbo@google.com>
Subject: [PATCH] iio: adc: qcom-adc5-gen3: Annotate struct adc5_device_data
 with __counted_by_ptr
From: Bill Wendling <morbo@google.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, "=?UTF-8?q?Nuno=20S=C3=A1?=" <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Bill Wendling <morbo@google.com>, codemender-patching+linux@google.com
Content-Type: text/plain; charset="UTF-8"

Under compiler-supported bounds checking (via KASAN or UBSAN), pointer
fields inside structures can be annotated with the '__counted_by_ptr'
attribute to specify which field in the same structure holds the element
count. This enables the compiler to perform runtime bounds checking on
the pointer.

Annotate the "base" pointer field in "struct adc5_device_data" with the
"__counted_by_ptr" attribute pointing to "num_sdams". The number of
SDAMs is determined from the device property and assigned to "num_sdams"
which is then used to initialize "base" via "devm_kcalloc".

By ensuring "num_sdams" is set to the correct element count prior to
the "base" pointer allocation, and since the size of "base" is never
reallocated or changed, this annotation is safe and will not cause any
false-positive runtime bounds check panics or KASAN issues.

Cc: codemender-patching+linux@google.com
Assisted-by: LLM
Signed-off-by: Bill Wendling <morbo@google.com>
---
 include/linux/iio/adc/qcom-adc5-gen3-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/adc/qcom-adc5-gen3-common.h b/include/linux/iio/adc/qcom-adc5-gen3-common.h
index 39cbfcbdb101..b3e2c2f50e8f 100644
--- a/include/linux/iio/adc/qcom-adc5-gen3-common.h
+++ b/include/linux/iio/adc/qcom-adc5-gen3-common.h
@@ -137,7 +137,7 @@ struct adc5_sdam_data {
  */
 struct adc5_device_data {
 	struct regmap *regmap;
-	struct adc5_sdam_data *base;
+	struct adc5_sdam_data *base __counted_by_ptr(num_sdams);
 	int num_sdams;
 };
 
-- 
2.55.0.1082.g2b9226bbc0-goog


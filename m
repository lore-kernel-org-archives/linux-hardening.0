Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03532D46A1
	for <linux-hardening@vger.kernel.org>; Fri,  1 May 2026 08:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777625640; cv=pass; b=rdh2YLPlJ9XCxCkHn0hgHaDivwNjMIVuIblCMsCz7N8UbPMp15yh9vwbcATeA7BaOK15cfAZAkwRVBFyRPgQpFdKynvj5Y1xSUPuApDfdlxFL+Nor/M0Nh8hoWYq35a2Wpk24vfLN+I5eRfet6UH2h3kLrfnEtdK0RIQzlLdEb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777625640; c=relaxed/simple;
	bh=os5GFFAfLMA0ND281IKJyTEl1mrWwqTCou/+qU1lKh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tIhKwozodm48Q4jKO+NzdlvzUueUJ6zq9lY1x3s4Cnb4v/Rwpf4vEptU3WFh2M8L0AeCVw2SGJYMKN4H1Bv3pP7xXfVx3pp9fF3r1LCITCR9E9229bNEFzxaTPtl36jZVKU4sXQJaDeEiGMO2woN1OgL/UYPRjnrNSDM40tT5dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4Rtse2N; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4Rtse2N"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ba36357195bso228726566b.0
        for <linux-hardening@vger.kernel.org>; Fri, 01 May 2026 01:53:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777625637; cv=none;
        d=google.com; s=arc-20240605;
        b=GzrAfvLJIrof0R6sY6HST8Z5nENdKFJAy+flUFRfL2ovJYnUtEz0XrlVZmUn4ytjlu
         5v+GAoq8VBtkEamFvSkuLMkpqACcyHpeCYz6t3WtLFWYYMF945FklLU80gZd2JdINGUZ
         IGA1ZSYLqtPUTGU1Vwq3FumJ63kxbiF1QtdE5w26xWZSaVbWSzsQBU9OUmBaxtufHkze
         upt/ev52dVMgAyTjqhH2BH4mKschYm72uqq7Lqq7jNx5N5pBPKkhyeS0pNgtU3DN89Hd
         FE+Uo3ws+dH45bjLxVDcqqJ1/gzjjpVfE0h8QVrYRwWCL8BtPAXOuIaJy4EmivzFeSnt
         ktuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=os5GFFAfLMA0ND281IKJyTEl1mrWwqTCou/+qU1lKh4=;
        fh=aRkvhPYoPvVrSS8JRl2IeyVa2JkBKjdwPBfonhrlg6c=;
        b=baiMpu2gtMJZw+dCAW54OfjE3ktKok1qHQyWTccHpVR6BK1AGRxkq2mzIxC41rGut3
         NywgYvuG2SZQ+vXkD2qfsHmCJ5F52Pq/dOGJYXqziE7UBM10V+rUEtMhxRdls05ZXq2x
         D2He1HYY+dqxps7+Lwb5TCpH+XuBeRjNRqefNT6n8VXdHy7i4wMryyvgPeZ5fFUeGq1M
         7rzQa6RndZB5oVwjlK/42N4seHonG3lZLBLLnDL+zX4Wqzz+/Xkd1gVe77OdsyJ071fg
         SYOrfpCQm3MPpWz64P18pV+Qq7lEOaB00GLoEqJjJ+wGRfVl0R3Mfj2nzRQa3cp1AApt
         4NyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777625637; x=1778230437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=os5GFFAfLMA0ND281IKJyTEl1mrWwqTCou/+qU1lKh4=;
        b=R4Rtse2NJvk/Jp5k/O/AcJb6GUu83+B/2lSEWu1F0G5AEM8NasOWxxWMsXXqL/mGeP
         iytkdq1LzlEeaLa39aRNwmVn5ltMVsgP0F4xzmbaMulsRL2Erh4mVEci/B5hrR2MMc8O
         gOoG9E7/Q6TVPWPipuTsmp2KnIjrjLSI/+YbHf/p8S2u27BJz4GwfNukmaMpqnVKXHAo
         Amj95Tlwtll39hnZnknGsOMulHkJIqbClLVb6DW/oicLa+e3V7ZxgHKIIQ0DLe1PeVww
         xrQZhH9b4ObhuE1PeItLF71bpqQB++VzL+PA+WJKuTdESyta0xWBC9FRt8m4LGRwdYCm
         9atQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777625637; x=1778230437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=os5GFFAfLMA0ND281IKJyTEl1mrWwqTCou/+qU1lKh4=;
        b=ichBhOVcI+8VBESoO2SZA0eywhHJHdjtUQGDRcCjVVuYGu6pvsxWfPp1ihEEgOm3AK
         KaHui9U4mrN+VSnQJD8HSk3DEQHpybLesWvuQmqNjUzVRRmkWiF1465W4HJYiGYCEHyB
         zOoCmUvbN79lctVtUbLHFfHhIvaC1jEyRU8cDd4KN3e03Yhy5n/OVv83sryMW3JvCRCx
         clZZKFohnPwVItfUvhuZ+c5mANu9xRoP2rDk+wNtX1T+A5xv5pT+VxqYvMtaPtFygfmY
         3mGOTP5tpT9oJKFpqVk9l0OQgF3LbGCJhh9FIGralZtoRfgU52WUmrU6RnggQ5j1qbmI
         Yjxw==
X-Forwarded-Encrypted: i=1; AFNElJ+W5mNdc34f+iktKspLdVp//5KaV46eiyeupQEZis1+V6C70oTDUfXiqV/i5U8g5SjRsQKweeqfes3Urvd/T+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLibC3wPwi37JNTARcv1dRBK/9Mc5q7JasS1wRKSMkIUJAhyKV
	Uas7cKzB6mTumIjNHpR5FZOYuWGjrdu2OjbAOBqnEf5x2YjcY07tA9na2yaVmLdOfP4Z+4IoD48
	RjsIbNIDUggJ9jqzzWz0oIJ6LBrbWeeM=
X-Gm-Gg: AeBDiesfZafN9rFB7/QsIFqjZOHUo2tB2bRMvdt8w0kYLcaZv7e6s+G1E2UIzf0rfQ8
	4nQa4uuAvWD/tndihlB6xOVHHf9XLhe6D+vAXVAAqba6HR/vTDknOmGHlu/jCvuLnX6mmV5I0L7
	wbDJd84mCqugqT1n/TRflp3p1wG6yqi3J6aOBVcLScVAibOwJa/HpZwR03iv/IWx0pP1lVoxvOW
	IQgr7wq96VuuoYh/5OvO2oIGVtQjCSmK0TFTRvF+bvD6qJ/VodSv56HpqYRkwJ1aPj4BO21OKmT
	UWNiAf9m4a/Dm+OJlTAffr8mNFtOfLgq3LFDh1ckLBwqS+JqO8nUxpcCqJjHg64Fj4wV1dORjbL
	hNFS8UZFKsbl46dcB7La+twC7hXqm/Q==
X-Received: by 2002:a17:906:4fc5:b0:bab:812f:a894 with SMTP id
 a640c23a62f3a-bbac788f97fmr381798866b.20.1777625636727; Fri, 01 May 2026
 01:53:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777529232.git.jqqlijiazi@gmail.com> <2ec1942dae69caf3c387e68a65091f84c40249d5.1777529232.git.jqqlijiazi@gmail.com>
In-Reply-To: <2ec1942dae69caf3c387e68a65091f84c40249d5.1777529232.git.jqqlijiazi@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 1 May 2026 11:53:20 +0300
X-Gm-Features: AVHnY4InKKV7m1OonLkxuOCTAKEH1caJuvvInsA2ZL6N_OwnxFJPKVkm01BWf08
Message-ID: <CAHp75Vddn8xWguwZJLjtXZmA0aWUjRL5OLnOR=Dv=MRw_SWBFg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] coccinelle: Add rules to find str_alloc_free() replacements
To: Jiazi Li <jqqlijiazi@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	linux-hardening@vger.kernel.org, "mingzhu.wang" <mingzhu.wang@transsion.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 9:41=E2=80=AFAM Jiazi Li <jqqlijiazi@gmail.com> wro=
te:
>
> Add rules for finding places where str_alloc_free()/str_free_alloc
> can be used.
> This currently finds 4 locations.
>
> Adjust the position of some coccinelle rules, so they sorted in the
> same order as they appear in the header.

...

> Suggested-by: Andy Shevchenko <andy@kernel.org>

I indeed suggested sorting the coccinelle script to follow the order
of appearance of the functions in the C file. However, this patch has
two changes in one, and the second one I have not suggested. So, split
these to two (the first one is sorting one, which may have my
Suggested-by tag, and the second one is adding your new helper).


> V2: Keep coccinelle stances sorted in the same order as they appear in
> the header.


--=20
With Best Regards,
Andy Shevchenko

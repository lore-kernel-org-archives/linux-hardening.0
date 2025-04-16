Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F45522A801
	for <linux-hardening@vger.kernel.org>; Wed, 16 Apr 2025 07:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744789074; cv=none; b=E67kD7gip68Kk9atC7EK9X8KSAiFr4I1fdOuIRrhnUeDHvDNQb1nLB0VN6oZqSw/6+Uwvywt55iy9HPt82G++a8qqKkG8ec8VFA15KWfi1UKkc6t7JdhFrre4QuHqO4sJMREz52HeFTCbMKrOaOinpxf8dNpPD6ShmFFX0AciQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744789074; c=relaxed/simple;
	bh=/dHTnIqKv1XUtEnnIqSrU6JfGL02W+RqBJVzPOERN8c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hUeNgxFskwsYJzhYZ/YWSSWUecZoowlqQ5XLTLSfjVZ3AI3UFc6ttCPvimDMftbCgb/crxCpVrHcPnohlZA0PFcpM8cZZ4OJc8fsjUH5/Z/lNxa2g166hQesFYEjX5FBr0S4DmZPY6opB4qwECURZnBuR6BoTctEYcOinb1L9sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=edj2n6gq; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="edj2n6gq"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac3f58b9156so74961866b.1
        for <linux-hardening@vger.kernel.org>; Wed, 16 Apr 2025 00:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744789070; x=1745393870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRYgw5eO5GQxlUJX50lZgpjYD+AakSIe/1el8VkKu44=;
        b=edj2n6gqCJS9T3K0oXcdFhpiPIngSGM7tur1SQw569jiQaoG1CKU3Y6BqeoaoTAJK2
         P1AGfGBwH+hOBJgDaf8/TF6jYQqCeVUBR2ixlR9GLa8fFwZat+m/7WjZkh1BNHD9Dnzb
         dKlPuLUAxN8XsHEPa2JR6UsETg/RAsHnQlpoStDb++XSTfPv5yJ8TI8R1IiqAC6O4UuN
         dGeWDWhFfd6Pc43ROLY3d+/BMAFOpQi+qGYiGabHUOqMvmzIRZA/YQrMsH7ZXBpJlV/r
         iV4jqZ4iDYudLsMCQEpRCfysxXZ8aNc3hGY09Yqz8mxQ905xzDVlqVI/OiCOiD4NKFmF
         jpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744789070; x=1745393870;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PRYgw5eO5GQxlUJX50lZgpjYD+AakSIe/1el8VkKu44=;
        b=mcxXyv6l+FnSHLfxPggO+mJBp/kjvpXuVg4mZwHcyNT7yNZalxVCUoOO/RRPWcsHNC
         ZGOti4gGDnOS/a9tuo67UiW5GP+3cldHIt5SF37IDomosdE35/4VbpJHL9911gQj2WC1
         cMmnrUVUlW/WtEwNUUjUl4r+B1ls5xqMt5gn4eJQid4HFzAvURiglb/AIrB1gUvtvupg
         njAOY/sYKDLAtE40M90MRHOyFtxkfaChLLRcyRj7gvBUG6noC8LOi6fBbxS262OZhLsY
         v9CQ90/csMJ0YopY8lz23klSXwcIkcz1xyGC3C/pNCeJ8tIw/Vpf+QiY4OXzO5O4sGkG
         e7oQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9vMkgHTDzGxOdx04TWPsT5KIzauhoIacPFhe84V7CHAf0tEOzU+1s4yMtJqdb6XTNGTMWqE8kbgKnPv2MeIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkmF3ID6xGr9UJWlQnfVFaIuEVr1g8ZjCtu430qG+dl2QhqMRz
	dF8gjqwCJ5LLc0onOkWJfnVJqbQj3TsLjgHW4dzxiwJ/rBUzXI8s1GtBpGVvCHM=
X-Gm-Gg: ASbGncutJWk4ECNQRCeKcs3aKqmCS7IfTNopvoQ2si0dm0JMqvJJb3MUqEW+qe3GyV2
	rjYVEh5L7BczagXxMgyz6d3s/LtQZUw58Spk9X6NYnzuQAVe2/dJD5BK5UfNq6NcrwUVI3FBMoi
	Pdoh0ZcMnWVmK5yIqB7nlOs9FQpt2+7ugcXAdN0AWeLU/r8MuTzF/gdW3qK2qafFcBtiBx7h34a
	WWDDbwJNgYMNsn0I3D/hrUHe6nKwSd7LmIOGGiDS6BYegTTOMSg2sA0obbOCLRzDvOzGKdSrSZ7
	BDGX2AG9BOCgE4WXsOnPBuw/kGna3L0WaDG20f1mKXSaqDVpphYoWpWLo3SH5T2ABjCY2Kciz5a
	JMUOY5mnabhiZWjI=
X-Google-Smtp-Source: AGHT+IGGDPu8p/m7Rp/p9mRRBOni1XiQkV2RaJnHLAJhksBbAx8CjdUPnxxzVfx8pJ0atl4HAQG9Tw==
X-Received: by 2002:a17:907:86a3:b0:ac2:1d34:44ff with SMTP id a640c23a62f3a-acb428ef998mr22714466b.4.1744789070418;
        Wed, 16 Apr 2025 00:37:50 -0700 (PDT)
Received: from [192.168.1.26] (46.150.74.144.lvv.nat.volia.net. [46.150.74.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb3d1c849dsm75324966b.147.2025.04.16.00.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 00:37:49 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <Z_RflBe5iDGTMFjV@kspp>
References: <Z_RflBe5iDGTMFjV@kspp>
Subject: Re: [PATCH v3][next] w1: Avoid -Wflex-array-member-not-at-end
 warnings
Message-Id: <174478906927.19176.15442189860155457011.b4-ty@linaro.org>
Date: Wed, 16 Apr 2025 09:37:49 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 07 Apr 2025 17:28:20 -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the `DEFINE_RAW_FLEX()` helper for on-stack definitions of
> a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> [...]

Applied, thanks!

[1/1] w1: Avoid -Wflex-array-member-not-at-end warnings
      https://git.kernel.org/krzk/linux-w1/c/a9b3ecc7bcf6cb8d3c4947a7ae260f508c4c5fd1

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


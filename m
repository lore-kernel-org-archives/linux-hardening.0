Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AE94BF941
	for <linux-hardening@vger.kernel.org>; Thu, 24 Sep 2026 19:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790277955; cv=none; b=OZ9jR5gjvZE2eI/e5rfj7g/pTntObuZUIdum4rqrjeEkwPZj/FP1gnh4AwY1Eu2lBqnZnrHPp6WuNwrE4IOcw4GcMiaXu6V1LJSqzXlTHfCc5t/4ELD3tWnHPyr4ceZg51OM08yAuUPWxFuP4dj0bb5unVg1i1ajZRhBL1EsRfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790277955; c=relaxed/simple;
	bh=yl7byw9V/8EXNs2araC6QFRi1x86VMjG7XO2NiJSzk4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fc7xlSSR/qAh3mFhstKAqlktHPRkuSn0CqtP66eAoSj9wYA1d5f9pTHiYJTjm9rQjLbGa25Hm11jH+Wn7oSTQlzdyVECktIXTUb9YqDIdlPw35rdHfaSRc2btH+2oECQ7M+3H788Do94L2FGpL5UynSUvX1h+TEdNe76KcxLUBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JeIJ+BMZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JeIJ+BMZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790277940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nvu4jmSjpEKtUCT3yeOXCWZTbIcGf9M3fr7tv012qzc=;
	b=JeIJ+BMZE7GECXiRita4G1m1Gz9PJvhEVzUj0vAS8BPtOzLXzuLcLcTUM53gpUzPMQntbl
	DK7EsB5VdwxaaWPwFdJf+oIx0IA3qZ+eUEXn2Edi8nFn4ufJSEJkv+s7sgqLBEAoKkTFfl
	mwNnaaysMNv0FOQSaF46wEXtmBhGQ/I=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-7AUkff_kPUGi7RDKXxRKOg-1; Thu, 24 Sep 2026 15:25:38 -0400
X-MC-Unique: 7AUkff_kPUGi7RDKXxRKOg-1
X-Mimecast-MFC-AGG-ID: 7AUkff_kPUGi7RDKXxRKOg_1790277938
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-836c9f68dcbso3912157b3.0
        for <linux-hardening@vger.kernel.org>; Thu, 24 Sep 2026 12:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790277938; x=1790882738;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nvu4jmSjpEKtUCT3yeOXCWZTbIcGf9M3fr7tv012qzc=;
        b=e7G4vJx+GaEfHLhD1zcMIiE4hBdFLPqO+BFsuwTkVGm4w1MzRopjUZC6U820UB4llA
         fh5jxmz9FU259dthdlSoB2vDozfgU2EhHzukCq+gm/m9LKfEmkWzad4qCKn4Df8iDvu0
         JqzX8ykbRR2ab9Octts4Zi9qQ3kVAc+T3u24rD807x3vw9z+tQS/ONrIhk6b9YayAf3j
         BHZwwPSEbu8xbQgT7AOd9+Y8Z0bsEFNZUAvaWPa0H9Y4pR2DeUMaBeurqcTyYeHCP0z1
         ZtzA/5+H4K1gI9D7VPfmR3eY2NiPUJXhRxHuUxDxUSot4In9JM+CE50VWw0Puydllc0c
         ArAw==
X-Forwarded-Encrypted: i=1; AKwUvBx1ErIMUSGusm7P4CFd4q/FqaZEGYFPX9c0n5bxEJD5ZPJJlDFIqiI9kKWLwlfiDKxf0YTjTqB2N489GkhK9p4=@vger.kernel.org
X-Gm-Message-State: AFuF++nBMz3e/CZlgYVe0c4cj7WwB6+qIJQdszlBVXb7colKhN5HwhCI
	DDn+NqOjtBhwhv9ay24sqQANHomWkKShQjkzVkPF5eBGjCob/wcaABmZ0TSRryuziL82lekMsl2
	tkPGwV135WQQsaOcevl9gh7VdJkosVyR71O9HbX8K0Sys/6+E52l4b7jRkk6L71wQFgKAaA==
X-Gm-Gg: AYBFou091XvyRmZGbkEHx996XTue8SuWZv3TWZf3UeERPjDOkzFoFSDJ/ppxpHMwnSN
	B3IkLYem8tl3QS5/1PH/ZagiSfDGIO5JkUD2fWEs52Tn731MLh66auo+QYkqWObDWo5w1o7xdA6
	jMsUNsuIiJCGwOpv55qsZgn1liWO6ZlMq8Gchq+w8HAbYtBQD1lCrCFMRTBWfdlJnT1WnblHW8d
	5PhVez+Es0dnQHS7Qc7fP070bs9qpa3uemy9/b7VvUwsScvFXqkSRiWe2anAt2CS+t/atvCVC1t
	6xkX20vBzyg/97uTIQ1gzp/ttG5OyngVTOfbl3B3PSelvp92cn6bcq4rxzui3Ud1Z4edBnjZs01
	idWC6lZw=
X-Received: by 2002:a05:690c:6607:b0:868:505e:b935 with SMTP id 00721157ae682-8a64bb008c0mr22054677b3.13.1790277938281;
        Thu, 24 Sep 2026 12:25:38 -0700 (PDT)
X-Received: by 2002:a05:690c:6607:b0:868:505e:b935 with SMTP id 00721157ae682-8a64bb008c0mr22054527b3.13.1790277937833;
        Thu, 24 Sep 2026 12:25:37 -0700 (PDT)
Received: from [192.168.134.224] ([2600:382:8501:4f43:e566:7498:c7c8:a7ec])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a860e5a5e9sm1031967b3.17.2026.09.24.12.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 12:25:36 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
To: Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Bill Wendling <morbo@google.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-clk@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, codemender-patching+linux@google.com
In-Reply-To: <20260922110601.1959213-1-morbo@google.com>
References: <20260922110601.1959213-1-morbo@google.com>
Subject: Re: [PATCH] clk: tegra: annotate struct tegra210_clk_emc_provider
 with __counted_by_ptr
Message-Id: <179027789851.211017.14017390990337858574.b4-ty@b4>
Date: Thu, 24 Sep 2026 15:24:58 -0400
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=355; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=yuS8PUHpyjlmxe/bLBUuHCrQMMO3MXVmrvfWzdbYyP8=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLK2VmpOuG07yfjjy7Z1G4vOC1trzMrY6ObP/vv2JuZHR
 1dIrmqQ7ihlYRDjYpAVU2RZkmtUEJG6yvbeHU0WmDmsTCBDGLg4BWAiIiaMDLuWajPG8J80S8wz
 m8g+ide+/k6w7+bZm3mkDlhaRVzK3sPIsO52hPCLV16fpLdfu2EgPPVex0GRoEtfZ5TKizPxXPB
 4xA4A
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: E4pOBnDdoBbrY7ob18h0N895UayiGsmUI6428a4f-Yc_1790277938
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit


On Tue, 22 Sep 2026 11:06:01 +0000, Bill Wendling wrote:
> clk: tegra: annotate struct tegra210_clk_emc_provider with __counted_by_ptr

Applied, thanks!

[1/1] clk: tegra: annotate struct tegra210_clk_emc_provider with __counted_by_ptr
      commit: a1f2029b89ccd7bef54e187384417db4d72d0a11

Best regards,
-- 
Brian Masney <bmasney@redhat.com>


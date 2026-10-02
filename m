Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4478E3E2771
	for <linux-hardening@vger.kernel.org>; Fri,  2 Oct 2026 18:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790967116; cv=none; b=qeyuPwpuLFZeB+l0UyzEOuNP4JqSAWBsfsC7rUS6wGtVanOgfkVZKmqDCslFOlh0jW1D+P3g/tD8116a1xlb/m7uP60DwpXJm8Lk627oy2MpFllb8YbnKf1lDnBoLI5kxvOgcKEC4WvVjhgW0+PmznEbIuCOBIHvc45v8BSoUF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790967116; c=relaxed/simple;
	bh=SvlLnlt6KHX1Jrj2D3pJtCaILFR/9gRc9iadqwmEB5E=;
	h=MIME-Version:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:Content-Type; b=akO21kChUfKj5j/8MfV3caQ85ZAEe+7LdF1ZJWSi+ZY8ftnykhNvSjSDnSr9SgIt8QkkZgeHnBHkFLwqelu1QwRLvi6NymSQ8aatnADFphX4L6j9hNlEpEHd9Pi/NRRvYvpg6CRgoPs7wx6AOzV0qRP3v82nQJOgGYiLqNEE7ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AWpa7z0u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AWpa7z0u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790967112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lViRkD+J4l6mElusP3QWY+NSQ6ORF7js4Y4aeDT+mp0=;
	b=AWpa7z0ukoQgwGG9HhZrs2nPndVK12Rd5Ui+rTSjt0jyKJH7ley3EWQz2nE44bMfUtGbeH
	Qa0chSRyMFYh6QSIlCyY4lVMW+Q7sQDcSO4T0nS84t/hK1/ZMbhK9XFy+pKkVL9pG0O3MH
	j5yhN19XM1qjqyubEgTJbS862jq4Y2k=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-KxBNtFYDPuWyyLAyjiQaXQ-1; Fri, 02 Oct 2026 14:51:51 -0400
X-MC-Unique: KxBNtFYDPuWyyLAyjiQaXQ-1
X-Mimecast-MFC-AGG-ID: KxBNtFYDPuWyyLAyjiQaXQ_1790967111
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91786869e8cso3229226d6.0
        for <linux-hardening@vger.kernel.org>; Fri, 02 Oct 2026 11:51:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790967110; x=1791571910;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lViRkD+J4l6mElusP3QWY+NSQ6ORF7js4Y4aeDT+mp0=;
        b=co0x9FnTJRoGFMn5iLIjQUA4qCBoBio7ndBz1wRgaGXPFNepc5vTLwParJzDjzIiCe
         v9omShLmh21phdekjTe/iA+Fkg3o10SPq5Zfvsv5GadbM0fIe31JiNC8vfHy+CQTaHcx
         U4p+2LpwCuWWj2kwYbep6Ie9odyO0qkuJgZ+k1Ybj1oe/KU34tZ0jGv1W4J6e0NAPRY4
         GbPgRAx5A7n4HY6bO6m5jG2oR9LCJz7iBIo6cYNMwQPPCeH8CEptTQh1Aq+U5siPwV6r
         l0z+29ipZdBMXiQRiYflnsUPyW+mLKkF8lb1jvEVIphnfOrBpgqD/aIkiiKYqo9a7/TH
         PYqQ==
X-Forwarded-Encrypted: i=1; AKwUvBzR1hjeswr19WabjDIghICVGb85Mzh+o9+XxU1tp1RIwD1pvOmX4K2YbYX8fAD9Q8Q9PJJYCjxtblHgINTjoB4=@vger.kernel.org
X-Gm-Message-State: AFuF++loNdHS5Eo3am30jU2R2TD3UETtlXQDPecQAfAW6VQlWcPT9Frg
	YInSLeFyRnJUMIDQCq18vJdU6Ub4n8ReK5XGyX44hkaa9JCqo9S2PDTrJrKF7iYscZThQi26UEK
	fsAZkAIaQnWU9qy+JIh3MsWxQ8CsdJC/0INqYAX68DnBxZofalcLPycsS/Y0+oPCIqNGRgQ==
X-Gm-Gg: AYBFou19tWvXsG0maJHbF6kL+1jzWIIPRgeKSrGC4v6hqVv7SR7JMel3WOy/W6Yaf27
	sntmrJelYEZ5DaGglGJ/mXjONdzp/DYmxz6LQSmXf0Mft0ddcCl5dXj44QifwoZeXZdsfuoRPBv
	7OM23qwxHV1RUG+z0upXFItKhNzGlQCjmQOyf9X8SSO2zrW0PPyQp0V3A28NXki5A7QeXl27X3m
	/9P1dUUUrBEr5+/N9lD3CKXzXsBlAFxS6rVguBeYvduAtSFcsH64PbEUtQptspi3JR9QggjAp4g
	2P1RLVPU6PdjdcXQcJhIJ7X2w8NbjCk9+/KH2MxYKi0JmF1kfkvfM8XA9RVezp73xGQPGfvsCm9
	Gf6207UDfFRJEtA==
X-Received: by 2002:a05:620a:bd4:b0:93b:c58c:d3be with SMTP id af79cd13be357-93cf17664b4mr670123985a.37.1790967110539;
        Fri, 02 Oct 2026 11:51:50 -0700 (PDT)
X-Received: by 2002:a05:620a:bd4:b0:93b:c58c:d3be with SMTP id af79cd13be357-93cf17664b4mr670117885a.37.1790967109968;
        Fri, 02 Oct 2026 11:51:49 -0700 (PDT)
Received: from bmasney-x1.rmtuswv.csb ([2600:382:7723:4eba:66b1:961f:1a2d:af55])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca03a1bbsm290352485a.1.2026.10.02.11.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 11:51:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 06/23] clk: starfive: Add JHB100 System-0 clock
 generator driver
From: Brian Masney <bmasney@redhat.com>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
 Brian Masney <bmasney@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Emil Renner Berthing <kernel@esmil.dk>, 
 Kees Cook <kees@kernel.org>, 
 "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-hardening@vger.kernel.org, 
 netdev@vger.kernel.org, Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <20260930124317.5648-7-changhuang.liang@starfivetech.com>
References: <20260930124317.5648-1-changhuang.liang@starfivetech.com>
 <20260930124317.5648-7-changhuang.liang@starfivetech.com>
Date: Fri, 02 Oct 2026 14:51:13 -0400
Message-Id: <179096707364.821688.18177370718453496156.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=922; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=SvlLnlt6KHX1Jrj2D3pJtCaILFR/9gRc9iadqwmEB5E=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLL2/7X6vESXVZZr6Wxj3c4lz4Xy5qcm7nt4+OjFy0fUf
 A+ZPjGe2lHKwiDGxSArpsiyJNeoICJ1le29O5osMHNYmUCGMHBxCsBEEhsZ/ue2hf3l4ON+PnHv
 SvOQsrfpJYHf/Bvm7VBe9Kfo56vsPbqMDKs+HVC7yjLx7g35VuZFnkG3JLSO37uqbflrXT1jv6R
 dLzcA
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: G14ZE5sBd9_-Mzk5J5eD-jA7nVGiollWqiCesUe-A-4_1790967111
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Changhuang,

> Add support for JHB100 System-0 clock generator (SYS0CRG).
> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4f72b4ac27ee..a0e5b4df96aa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -26097,6 +26097,13 @@ S:	Supported
>  F:	Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml
>  F:	drivers/phy/starfive/phy-jh7110-dphy-rx.c
>  
> +STARFIVE JHB100 CLOCK DRIVERS
> +M:     Changhuang Liang <changhuang.liang@starfivetech.com>
> +S:     Supported
> +F:     Documentation/devicetree/bindings/clock/starfive,jhb1*.yaml
> +F:     drivers/clk/starfive/clk-starfive-jhb1*
> +F:     include/dt-bindings/clock/starfive,jhb1*.h

The spacing after the : doesn't line up with the other sections. It
looks like this is using spaces instead of a tab.

Brian

-- 
Brian Masney <bmasney@redhat.com>


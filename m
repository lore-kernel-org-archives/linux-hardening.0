Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5CB1804A
	for <linux-hardening@vger.kernel.org>; Thu, 23 Oct 2025 10:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761216193; cv=none; b=NflfIkexqAYWAkteWG0RK2LcFsYXTIq8aZIgFK9diGCXOB5IyI9ydOKgQy0gbhgE4E469Q9u6wU3y5I3a3qE0Ut/TezYwIIf8p8kF/xZt4TduEvr7bqZ8ubBRKRk6OSapc67peVEqt1C9cvffLZwg9ka2OlnAGv56UFhvd+EFpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761216193; c=relaxed/simple;
	bh=PSq4rzHsTZYmnPW7B8CFsP6cGQe5nHJwDQGMbKTQhlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QfvDfRrn4Hp3Ze51t/3si78qvtFi91Z5kO8WFGU3ZWqXZG2E/XO3p5/v6rfL/rPy/TPDdQ44GloQcVwrUr/IwKzPV+vtjKRXpSeGlo3mb4kSleQC4poXCbm3I6Q3KndQb+bXXMfI3yjJU/uf6784vaAv9ErmWMVq4sp3atfYcYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=faeMJken; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="faeMJken"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761216190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2itfR4P5vWlnhxtQmgFjh+n2XUI3sGLIeHL7uzBaLr4=;
	b=faeMJkenuiVG5UbIwru6FpNkyIvAFHukAyfXMevSRiu5Mg8CG4Ae3JoKPYe9uKZ9pG5jH4
	y1CkenBd5v0f02TGQ9FXPaptGoElv2ZwBHM3Nswia7Rqq7elDEwM8qqZVdkNBB4dhZ97/p
	I9PR5JfHyP/IhtJvTC1s8Rhb9AQyia8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-o7oygs2oPru8mQiW2hwkXw-1; Thu, 23 Oct 2025 06:43:09 -0400
X-MC-Unique: o7oygs2oPru8mQiW2hwkXw-1
X-Mimecast-MFC-AGG-ID: o7oygs2oPru8mQiW2hwkXw_1761216189
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-475c422fd70so3870165e9.2
        for <linux-hardening@vger.kernel.org>; Thu, 23 Oct 2025 03:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761216188; x=1761820988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2itfR4P5vWlnhxtQmgFjh+n2XUI3sGLIeHL7uzBaLr4=;
        b=TMZHb2gM/n9AjgcrKf4SFfIFMArxTmooPx8UW0WyhJhEE9KBwttBqc/AKF6lnorwLA
         UCOVXtZsCh0QhAD6IC0nR+AA8FS9O45LmCX2ZDeiazS7k/WuB1yXPaPNFpkxvfIHHLYT
         NT3iY3hvCjxKlr8ikbjtHNtfbLPi9kLIyuSr7KaFrJoE3QXHZtGc3dVxSs/TlJFWQ/gG
         nT4XcTYnkq6qFG3zkJTpUe6aXRjcKeLQvv15SEmT4KpslCE29JhcJV9ZSkzvNqZeSpX4
         YlOwRbC5uDd0HchR/cUpQboxPo0pGaJzLLOS1O5cEoMCWkLn6swh/rQKS1vJ45gs1j7i
         CnBA==
X-Forwarded-Encrypted: i=1; AJvYcCWJicUED38YBodIx7JvWKPPn16NGyEA7EiuwYYFk3n81gNFiwMlNPV3yg1yODnXcdLPZ0Sx9biiVvxDnEy404k=@vger.kernel.org
X-Gm-Message-State: AOJu0YygwfZl20CRe9YnTu10f+8/93q1IW26/04zg+pS0QK7B/WXMh5n
	VfCiQIkehvZNVJxZ+l7KfN2+Q8Rkc6zmQIWhkJdE2MAQnnxN9H8NoAtu6r07C7yBPF3Zggy9AAk
	/qhjKKelDnrC7BwM1U05ORwNArm393q9Ymh7JxrhtSItcs4J3lwVteA2Ovep5XqQE1oPaHA==
X-Gm-Gg: ASbGncuuClD1cDc6hnAy24C0jZsAtYxNi5kpqlWq35M8xKjxga12LTS1J3Re2awC8ZO
	ivQXC2jncfsHh7GLl6bD/lFki6LveQBnekh07B2NHnSys/Kb7OWXlOg9iUAfjuJjGHXZ8haWZgO
	+ihcH5Pkb3gX6ff1opURcgBcH5EuiP/sMGLl5llzbpz8fnvQmxncgrH5R8aV0z3p7oVG+kvMEZ/
	FQ2Isp0XuNb2Mhhy20uNAOnRgWZfbGI66LzpkeOPZ9Y+wTz4B3SIdRSk/5dSIVaGiE8PAbn+hzq
	di5vmv6nPNru+qF/gQsKo812igfSR/c/qmvG0ipFMerr135uAm32m9JRNuX22W2wP+1hJgCYkqG
	YNyfyS8ExCaD5BLSiYH7EieArVySF022KbT2XYE4pgvI+C34=
X-Received: by 2002:a05:600c:3b83:b0:46e:3d41:6001 with SMTP id 5b1f17b1804b1-47117925171mr243744105e9.34.1761216188629;
        Thu, 23 Oct 2025 03:43:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeZ82VrSnvpK1c3qyzIXLRxmMNdmjxKL2P/cuqpRB9ovXOV8FGWqUSGpOdh0UCletrBUBh+w==
X-Received: by 2002:a05:600c:3b83:b0:46e:3d41:6001 with SMTP id 5b1f17b1804b1-47117925171mr243743745e9.34.1761216188204;
        Thu, 23 Oct 2025 03:43:08 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475cae92067sm31140865e9.4.2025.10.23.03.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 03:43:07 -0700 (PDT)
Message-ID: <268ee657-903a-4271-9e17-fcf1dc79b92c@redhat.com>
Date: Thu, 23 Oct 2025 12:43:06 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] net: Add struct sockaddr_unspec for sockaddr of
 unknown length
To: Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20251020212125.make.115-kees@kernel.org>
 <20251020212639.1223484-1-kees@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251020212639.1223484-1-kees@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eM77dxCshmF_hi4Gmb5w5FM_bdeR8rk-hw0bALfeLzw_1761216189
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 11:26 PM, Kees Cook wrote:
> Add flexible sockaddr structure to support addresses longer than the
> traditional 14-byte struct sockaddr::sa_data limitation without
> requiring the full 128-byte sa_data of struct sockaddr_storage. This
> allows the network APIs to pass around a pointer to an object that
> isn't lying to the compiler about how big it is, but must be accompanied
> by its actual size as an additional parameter.
> 
> It's possible we may way to migrate to including the size with the
> struct in the future, e.g.:
> 
> struct sockaddr_unspec {
> 	u16 sa_data_len;
> 	u16 sa_family;
> 	u8  sa_data[] __counted_by(sa_data_len);
> };

Side note: sockaddr_unspec is possibly not the optimal name, as
AF_UNSPEC has a specific meaning/semantic.

Name-wise, I think 'sockaddr_sized' would be better, but I agree with
David the struct may cause unaligned access problems.

/P


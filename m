Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E46611185
	for <linux-hardening@vger.kernel.org>; Sat, 15 Feb 2025 00:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739578283; cv=none; b=T6iGaesN9gPHEYVq7AhAxnBILR8x9qa85P6seVj0HOiHBhATyIwwOlygEnO/f4J0EKtTdi3xUSRN9FQ6GCTXx7tGPFTFgT2FTuc9Se8/kz4IY2u5+3qviUrsy/jmcuKSLHZjrFP/c1FSVVm6UoAr0J0LjJiX/UEIalrYNbTJzrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739578283; c=relaxed/simple;
	bh=onZ1kPAUc6cT2ONqq2vxhYFB4EuoKbTyxCj2hJ74Ta0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vp0NomMTu9y3rwC8rwgFEJf/c2YhKj2/UhD3a0FDjaM2qWjouSf1QBottfkVIKlsOCoHSrUerOX8I/nVLQ6KKxJqOipU8bViw/7A5DACV8uIvFq5TEsCU5dtoZpmk2vAnQjUmKKCFvryojvWzvMYchv7q1dUqvaxFSqpLTVhmCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=vVRek6KF; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="vVRek6KF"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4396a82daf5so10454215e9.1
        for <linux-hardening@vger.kernel.org>; Fri, 14 Feb 2025 16:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1739578279; x=1740183079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=onZ1kPAUc6cT2ONqq2vxhYFB4EuoKbTyxCj2hJ74Ta0=;
        b=vVRek6KFj8L91gyKPjue1LTQt1kRn46O/sjdhCeOpjLHmU4ldlGvU3d+bniZpb5kA+
         SocFVOUU0+CSiFXfW/h2sW/d1j41f+SjRms3v2QJNwipPEdbj5XtLRE3wSW4PyT9FzUv
         8iL9nUwvOtJRlRsZiCKFZWkwR/DAHNpSZAmDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739578279; x=1740183079;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onZ1kPAUc6cT2ONqq2vxhYFB4EuoKbTyxCj2hJ74Ta0=;
        b=uFMY6CVZA3pvRlz1dYcYyf6iM+HQmPl83MdbzssoiV0PvQdrIIUQtKVgHwPkm+RlTd
         dHWfiPHD8hoXF6wFvmz/bw6DJoHZQdTBdQpJoqYfS86LMUWbAU2hCX8INHEbB8FnQ3yh
         ad9ftKi/ZWh6FqeVTBgoPxK9QW9r4d6EwGbCioEk3foQ8IykgkZQOvbBHBJzkCTFg9Vd
         dpN1MrkpfpAGNBL87r1DTQDNFZ4x5bWq7Yi2pQn1i1gWQIEKvTPD2i+D9Z6jtfcCN2s0
         //HUP9Pg/advTyBqYqSQGN6Y8ZeIeCUrjmFGbnGFsh5oN3coiyWYjoE8B1J++YQGA5PE
         AcKw==
X-Forwarded-Encrypted: i=1; AJvYcCUPdatOlJluPBhcUoVYEIhJYYjN5bCycwb+GzltTLGqFCronj6AeIoXIJmUoHAcCbiXqzMffHSmkvS87etONls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7vD4xnUd+HQZK4/uKAuG1GqEZKZ7lyh3ubIiWv5mYvKxOXU2d
	BG6FCBsIrPcnl/1jn1qqhHnqmNmgFiI/I49CZADnh+wo3krDPMgFtF7O3saPupc=
X-Gm-Gg: ASbGncudn3iMgaKL+dw/C2sqaOnBv0Flmqxxw+ZjjaHELZYM0mUcw2MTGY5OmjQSuVF
	kO+5SllDoF1V+b8Eb53ur/owLzd2Lr0t+oH7dtY9Vqo/IH1QNwN3WlnogbjX5MnIio1iA9D4Htt
	LzwCPCcvGBJbqVBgqRg53zCQpjeZ2BQTdLdYWNs4B7fAV78izNUQwN1Arz7CdP/Fq/wAB2EfAI8
	mOsw+bzrPVHel7m2FhRuPX7FwRu1clPSHzU1hzJRqu0GMYm36CSRJN1eSPaGNObRQHig7wjCQPJ
	Qan6izGRcyt/aij5A0BeKZ0ZiX9npq9Xa4o4cjtk2X0eoXNai9OK/WI=
X-Google-Smtp-Source: AGHT+IHW6nl9/0gOopMk5eXRA6cgHUGHbRa5fOwKK3A4mfqejwctesQ+iVbKViZ63bC3P8RfXGkk3w==
X-Received: by 2002:a05:600c:3b8c:b0:439:6dba:adf2 with SMTP id 5b1f17b1804b1-4396e6c4f2bmr17217915e9.15.1739578279446;
        Fri, 14 Feb 2025 16:11:19 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ddba7sm5969488f8f.38.2025.02.14.16.11.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 16:11:18 -0800 (PST)
Message-ID: <48212481-75ef-43e1-afa1-ec1d603a91a0@citrix.com>
Date: Sat, 15 Feb 2025 00:11:17 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Circumventing FineIBT Via Entrypoints
To: Jennifer Miller <jmill@asu.edu>
Cc: Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>,
 linux-hardening@vger.kernel.org, kees@kernel.org, joao@overdrivepizza.com,
 samitolvanen@google.com, kernel list <linux-kernel@vger.kernel.org>
References: <Z60NwR4w/28Z7XUa@ubun>
 <CAG48ez09JuZPt112nnE6N=hS6cfCLkT-iHUAmidQ-QGNGMVoBw@mail.gmail.com>
 <Z62N6cGmaN+OZfoY@ubun>
 <CAG48ez0Bt9348i=We3-wJ1QrW-_5R-we7y_S3Q1brhoyEdHJ0Q@mail.gmail.com>
 <60447cd2-a8da-4be6-80fa-a5639b7455b1@citrix.com> <Z65/Fpd9cnUk8TjE@ubun>
 <c2af5771-1c16-4ac8-bc09-c33d07956358@citrix.com> <Z6/auDKBF1E0m/6L@ubun>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <Z6/auDKBF1E0m/6L@ubun>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15/02/2025 12:07 am, Jennifer Miller wrote:
> On Fri, Feb 14, 2025 at 11:06:50PM +0000, Andrew Cooper wrote:
>> On 13/02/2025 11:24 pm, Jennifer Miller wrote:
>>> On Thu, Feb 13, 2025 at 09:24:18PM +0000, Andrew Cooper wrote:
>>> Still, I hadn't considered misusing readonly/unmapped pages on the GPR
>>> register spill that follows. Could we enforce that the stack pointer we get
>>> be page aligned to prevent this vector? So that if one were to attempt to
>>> point the stack to readonly or unmapped memory they should be guaranteed to
>>> double fault?
>> Hmm.
>>
>> Espfix64 does involve #DF recovering from a write to a read-only stack. 
>> (This broken corner of x86 is also fixed in FRED.   We fixed a *lot* of
>> thing.)
> Interesting, I haven't gotten around to reading into how FRED works, it
> sounds neat.

Start with
https://docs.google.com/document/d/1hWejnyDkjRRAW-JEsRjA5c9CKLOPc6VKJQsuvODlQEI/edit?usp=sharing


Then
https://www.intel.com/content/www/us/en/content-details/779982/flexible-return-and-event-delivery-fred-specification.html

~Andrew

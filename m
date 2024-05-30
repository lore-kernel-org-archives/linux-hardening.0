Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61F58828
	for <linux-hardening@vger.kernel.org>; Thu, 30 May 2024 00:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717028701; cv=none; b=UqqdctuEesqqssZ8dZQsLLnff3wDY3WZ8XE0lepHyX2sFrSs0cjMEp3GJ6Ywm6SxWxF4uZeieCEbliiCdY7i95McLzgAoVUCpccli4xGzv2slN8RDUjkxnETyUnmECoMUY+b/VdXrLMgH6SfMChBwX8Bb6ms0EOqy3ZN3dna2kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717028701; c=relaxed/simple;
	bh=fi6T2j94Ji7pMV4CVbe0HpecLMs+r9lr+Q6XndjoPC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BaEz96EqnHTvVXv2/4O0HHYigBacTbPRoGpYJNYCK9hLRDFC8T6yWBams58Tfj4Wbkx8nOEWC6TfdewXJNz1sPCj3WS6WeZiUN/1R+qaPQbjr4pcCGqwKSzNw8jGFE9yelPk4Dp9z8qXhQGklV+NECu0oum6G1hqIcEFHyA5otU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=ZNm5rxnF; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="ZNm5rxnF"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-35507e3a5deso316356f8f.1
        for <linux-hardening@vger.kernel.org>; Wed, 29 May 2024 17:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1717028698; x=1717633498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8WU/Su/TdkCMJqoSn+Qk/ofrN8Qleakj9+qJnBXhLHY=;
        b=ZNm5rxnF18iGymBrX8CxLT/XRY86SaM+7TZAAN8pgwx10ZlQz1WGpbqUu/lV8phwMw
         7c5kkEBFzbe6JmNcpntYtmM9r4yNuS5kGpBNrkZ+E9pxB5OAkhqRurjrD8GBZ5sjLsXv
         s8xvhw0nlQweCKlKoxWdqsIh7t7qruzFeFEeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717028698; x=1717633498;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8WU/Su/TdkCMJqoSn+Qk/ofrN8Qleakj9+qJnBXhLHY=;
        b=izngktMmbyE2G0hbk3l92HMoNaylEI3Y7dWjogbiu5be1zyasl8kBXPahu65V0jN+G
         G4QIZJv9+4qLX0CRoGZzfBEtRklKp/vi/3KQS1ee+5NhosFo04PWcNh0VKz7BbhdTKqy
         Hr9p862OJ9tM6qXo2Be6bfuCKg6DxfQnpjL6D4pt94P45rTw7PhuZPhbzlMN4FQWjZ5/
         S8r8HuQHi4XxAhX12FxyBxnIFMKv8N7MG5WSAEWYR8tw5e0VB4sYytNT3nS2QMqSYjNP
         d5PXNIXc3Y3pZOuR8MeAQQeBn1HbUBFIJITRdNaE7KirGmt8s5kiIR9BmP8uVrTcYhUy
         hYOA==
X-Forwarded-Encrypted: i=1; AJvYcCV5v5DRxh/5oWfPWcNrSeR9+Kdw2j4HIntmszgElGUwJ+vvK5pRR2FWd0Iu0YR49+vCnD+ITG6N91VlfPsHcT1MShDsanDm3LPUeknNIuS3
X-Gm-Message-State: AOJu0Yx9YE+FlA4rbGMFObp9Q0bmwotkOCApxJpDTKLYO/+uXbU6vQpT
	dHKlMZtcS9ApTEDFt+/7uX/cXZxzFkX2T6jBkFLcdM0C91IVvDZqIM0NfqZi0+w=
X-Google-Smtp-Source: AGHT+IFZ7lX6qTYkNJQEilvQTt7HXeWa2peIYv2ELm1RXd6YLAydTQY4jMWLgRLWpf79Sr76ZX3JYQ==
X-Received: by 2002:adf:ea0f:0:b0:354:f729:c3e7 with SMTP id ffacd0b85a97d-35dc7ec9862mr169890f8f.34.1717028698143;
        Wed, 29 May 2024 17:24:58 -0700 (PDT)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212709d378sm8137365e9.29.2024.05.29.17.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 17:24:57 -0700 (PDT)
Message-ID: <c068193b-75fb-49d2-9104-775051ffd941@citrix.com>
Date: Thu, 30 May 2024 01:24:56 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/traps: Enable UBSAN traps on x86
To: Gatlin Newhouse <gatlin.newhouse@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Changbin Du <changbin.du@huawei.com>, Pengfei Xu <pengfei.xu@intel.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Xin Li <xin3.li@intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev
References: <20240529022043.3661757-1-gatlin.newhouse@gmail.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <20240529022043.3661757-1-gatlin.newhouse@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29/05/2024 3:20 am, Gatlin Newhouse wrote:
> diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
> index a3ec87d198ac..e3fbed9073f8 100644
> --- a/arch/x86/include/asm/bug.h
> +++ b/arch/x86/include/asm/bug.h
> @@ -13,6 +13,14 @@
>  #define INSN_UD2	0x0b0f
>  #define LEN_UD2		2
>  
> +/*
> + * In clang we have UD1s reporting UBSAN failures on X86, 64 and 32bit.
> + */
> +#define INSN_UD1	0xb90f
> +#define LEN_UD1		2
> +#define INSN_REX	0x67
> +#define LEN_REX		1

That's an address size override prefix, not a REX prefix.

What information is actually encoded in this UD1 instruction?  I can't
find anything any documentation which actually discusses how the ModRM
byte is encoded.

~Andrew

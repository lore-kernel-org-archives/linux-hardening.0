Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FC51A83F9
	for <linux-hardening@vger.kernel.org>; Fri, 14 Feb 2025 19:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739561966; cv=none; b=WWqb7BVFhO3dZuQmyXJWU9HPQKO5/u2dc1EsxDvY38aTpvAn42xdL+D8b6U4IcFXOAMUFfgnL6juQuTfNR0Q8fNcDibPIpWg+cc+Ft+u7l3GG/JEZvAkE+ipFXQtGK2HittF3FI4J6Pkov597xPgcwrD+VmXphWnsf1j9xfvgeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739561966; c=relaxed/simple;
	bh=xhXR7WiXEbWEK9s2/hr//izmZeE0Z65b63Lpwf4elBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CR2qLEvjDvf5Qkb79awJjcItUhTNb0DxugeNdQ/fGKMa9GQ1gIc4JH70O6mdTD4XvwwZrNS8SIwX0QjUaYUnDl97CSneSVt9pMqkZtTENLGMv4VRFY+RqCRn3sjlx5HWdWwcvT4XMjilA2nBiU5sjuC7XVQTcRe0uAkjgm5tn3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=T0arnYQB; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="T0arnYQB"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38de17a5fc9so1297947f8f.3
        for <linux-hardening@vger.kernel.org>; Fri, 14 Feb 2025 11:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1739561963; x=1740166763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mPz8IwHa6sNCZcb7usnuOuGvQU6AOa9aG4kdF5DAJnM=;
        b=T0arnYQB0Mum4/1p/T/amTh5YxCFQubCmAtLSUrJ77f+nnKUOTDjLE6ulY8gfX8A+1
         joVsgjkpX7ekiJTDZqoZUU64a1ACYF4sagWyJ3f3HsPA5tOyZ20ul68eiRNHZbrqh9UU
         MTYZFLzdMqTvXJ4NSAmtdBYlVp0MvQsfFz/wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739561963; x=1740166763;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPz8IwHa6sNCZcb7usnuOuGvQU6AOa9aG4kdF5DAJnM=;
        b=nHYYKbF6gGiuz7sFSDYXg4kBbJLcSWOWWxhXjbrAWfanswnK0HkQE36/nth2ybWgWl
         4KKHoFkCvIs4Dz8hxayF2MC/32O6Xdo1inD48Ll3jB+5LJApd5uqkdMgNx+b3KoT1ivs
         PfDsFkS8SPlUidggCqC3+jHbMp6c6uC6QX/fhWK+TN6TG9guN9YMdQ9IhEKAu35rmhBN
         1Ej2pL/KlH0lQ3V53FYMQ5Gsky1iXKkTH1LzMiKeXScPYK/1TVFHP7Xz1gkCn0t/Wbtx
         SgiS1u2EYp/ATboClVFpmitbUifj1SIrLaHDuRJ6+BuF95YsaUx+x9N9dJrb6m98reZM
         cV6w==
X-Forwarded-Encrypted: i=1; AJvYcCX0q6GmPtH5OTLorqE4ci8vqvPdYxhkGPNAZ//SHGRdLgQ09C8/ZroCIlLLR09Di4cIpu+nnt9f4gbTXumcaNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWDgaeVO5wxJAae1R3MothvuyhcJtmrHQQxY5247gQ2vsYmkDY
	6VODZ+Doyvyr3iFkO1o+2afCYqlGCPmqvSXFDm1eoDd+BxG7pB6O41UbJhOqBe0=
X-Gm-Gg: ASbGncvfcBusHWBvYC9Fffem7Nkn1XiC39Q9XxSvhr7oYAKVKMHNXljBBSwlzuyOJp1
	0WofbqFFzq6bgrHaw413HMMBhrWP+3hK49ON/AV4yaExx068WFA5YOPm1RJhwqy+SIAJjnQzMzu
	EFv6edV2Uu9MgTmdX/FEqYM5pCTKGMNMc70WxVQesGxo6uUK7MfYoPur2WNPzDmjs8m2z9OEVrd
	bnJE7lOF1zqDO5ApAa/ILnF6aPLH0ZH1x9WJvJluy0KpjKzCkPdzG8di9ZmHLq9zi9whXfPUHEH
	LW8OdihYfqqAK+ulkDGjDVlHi7ZaaqCsniRiJpQHrAoz04tHSk8jrhE=
X-Google-Smtp-Source: AGHT+IFUhys7D9vWfzjIblReIoA3OOJ9K1R36zWonnWpiLefrqsA+SQs+pRupA/XwizeDpiM4xlGGA==
X-Received: by 2002:a5d:6da1:0:b0:38b:d824:df3 with SMTP id ffacd0b85a97d-38f33f2e90bmr366777f8f.24.1739561961875;
        Fri, 14 Feb 2025 11:39:21 -0800 (PST)
Received: from [192.168.1.10] (host-92-26-98-202.as13285.net. [92.26.98.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b410dsm5390540f8f.5.2025.02.14.11.39.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 11:39:21 -0800 (PST)
Message-ID: <5d26bcdf-0e72-45b6-98c5-f90481650f09@citrix.com>
Date: Fri, 14 Feb 2025 19:39:20 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/kcfi: Require FRED for FineIBT
To: Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Jennifer Miller <jmill@asu.edu>, Sami Tolvanen <samitolvanen@google.com>,
 Jann Horn <jannh@google.com>, Nathan Chancellor <nathan@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Alexei Starovoitov <ast@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20250214192210.work.253-kees@kernel.org>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 xsFNBFLhNn8BEADVhE+Hb8i0GV6mihnnr/uiQQdPF8kUoFzCOPXkf7jQ5sLYeJa0cQi6Penp
 VtiFYznTairnVsN5J+ujSTIb+OlMSJUWV4opS7WVNnxHbFTPYZVQ3erv7NKc2iVizCRZ2Kxn
 srM1oPXWRic8BIAdYOKOloF2300SL/bIpeD+x7h3w9B/qez7nOin5NzkxgFoaUeIal12pXSR
 Q354FKFoy6Vh96gc4VRqte3jw8mPuJQpfws+Pb+swvSf/i1q1+1I4jsRQQh2m6OTADHIqg2E
 ofTYAEh7R5HfPx0EXoEDMdRjOeKn8+vvkAwhviWXTHlG3R1QkbE5M/oywnZ83udJmi+lxjJ5
 YhQ5IzomvJ16H0Bq+TLyVLO/VRksp1VR9HxCzItLNCS8PdpYYz5TC204ViycobYU65WMpzWe
 LFAGn8jSS25XIpqv0Y9k87dLbctKKA14Ifw2kq5OIVu2FuX+3i446JOa2vpCI9GcjCzi3oHV
 e00bzYiHMIl0FICrNJU0Kjho8pdo0m2uxkn6SYEpogAy9pnatUlO+erL4LqFUO7GXSdBRbw5
 gNt25XTLdSFuZtMxkY3tq8MFss5QnjhehCVPEpE6y9ZjI4XB8ad1G4oBHVGK5LMsvg22PfMJ
 ISWFSHoF/B5+lHkCKWkFxZ0gZn33ju5n6/FOdEx4B8cMJt+cWwARAQABzSlBbmRyZXcgQ29v
 cGVyIDxhbmRyZXcuY29vcGVyM0BjaXRyaXguY29tPsLBegQTAQgAJAIbAwULCQgHAwUVCgkI
 CwUWAgMBAAIeAQIXgAUCWKD95wIZAQAKCRBlw/kGpdefoHbdD/9AIoR3k6fKl+RFiFpyAhvO
 59ttDFI7nIAnlYngev2XUR3acFElJATHSDO0ju+hqWqAb8kVijXLops0gOfqt3VPZq9cuHlh
 IMDquatGLzAadfFx2eQYIYT+FYuMoPZy/aTUazmJIDVxP7L383grjIkn+7tAv+qeDfE+txL4
 SAm1UHNvmdfgL2/lcmL3xRh7sub3nJilM93RWX1Pe5LBSDXO45uzCGEdst6uSlzYR/MEr+5Z
 JQQ32JV64zwvf/aKaagSQSQMYNX9JFgfZ3TKWC1KJQbX5ssoX/5hNLqxMcZV3TN7kU8I3kjK
 mPec9+1nECOjjJSO/h4P0sBZyIUGfguwzhEeGf4sMCuSEM4xjCnwiBwftR17sr0spYcOpqET
 ZGcAmyYcNjy6CYadNCnfR40vhhWuCfNCBzWnUW0lFoo12wb0YnzoOLjvfD6OL3JjIUJNOmJy
 RCsJ5IA/Iz33RhSVRmROu+TztwuThClw63g7+hoyewv7BemKyuU6FTVhjjW+XUWmS/FzknSi
 dAG+insr0746cTPpSkGl3KAXeWDGJzve7/SBBfyznWCMGaf8E2P1oOdIZRxHgWj0zNr1+ooF
 /PzgLPiCI4OMUttTlEKChgbUTQ+5o0P080JojqfXwbPAyumbaYcQNiH1/xYbJdOFSiBv9rpt
 TQTBLzDKXok86M7BTQRS4TZ/ARAAkgqudHsp+hd82UVkvgnlqZjzz2vyrYfz7bkPtXaGb9H4
 Rfo7mQsEQavEBdWWjbga6eMnDqtu+FC+qeTGYebToxEyp2lKDSoAsvt8w82tIlP/EbmRbDVn
 7bhjBlfRcFjVYw8uVDPptT0TV47vpoCVkTwcyb6OltJrvg/QzV9f07DJswuda1JH3/qvYu0p
 vjPnYvCq4NsqY2XSdAJ02HrdYPFtNyPEntu1n1KK+gJrstjtw7KsZ4ygXYrsm/oCBiVW/OgU
 g/XIlGErkrxe4vQvJyVwg6YH653YTX5hLLUEL1NS4TCo47RP+wi6y+TnuAL36UtK/uFyEuPy
 wwrDVcC4cIFhYSfsO0BumEI65yu7a8aHbGfq2lW251UcoU48Z27ZUUZd2Dr6O/n8poQHbaTd
 6bJJSjzGGHZVbRP9UQ3lkmkmc0+XCHmj5WhwNNYjgbbmML7y0fsJT5RgvefAIFfHBg7fTY/i
 kBEimoUsTEQz+N4hbKwo1hULfVxDJStE4sbPhjbsPCrlXf6W9CxSyQ0qmZ2bXsLQYRj2xqd1
 bpA+1o1j2N4/au1R/uSiUFjewJdT/LX1EklKDcQwpk06Af/N7VZtSfEJeRV04unbsKVXWZAk
 uAJyDDKN99ziC0Wz5kcPyVD1HNf8bgaqGDzrv3TfYjwqayRFcMf7xJaL9xXedMcAEQEAAcLB
 XwQYAQgACQUCUuE2fwIbDAAKCRBlw/kGpdefoG4XEACD1Qf/er8EA7g23HMxYWd3FXHThrVQ
 HgiGdk5Yh632vjOm9L4sd/GCEACVQKjsu98e8o3ysitFlznEns5EAAXEbITrgKWXDDUWGYxd
 pnjj2u+GkVdsOAGk0kxczX6s+VRBhpbBI2PWnOsRJgU2n10PZ3mZD4Xu9kU2IXYmuW+e5KCA
 vTArRUdCrAtIa1k01sPipPPw6dfxx2e5asy21YOytzxuWFfJTGnVxZZSCyLUO83sh6OZhJkk
 b9rxL9wPmpN/t2IPaEKoAc0FTQZS36wAMOXkBh24PQ9gaLJvfPKpNzGD8XWR5HHF0NLIJhgg
 4ZlEXQ2fVp3XrtocHqhu4UZR4koCijgB8sB7Tb0GCpwK+C4UePdFLfhKyRdSXuvY3AHJd4CP
 4JzW0Bzq/WXY3XMOzUTYApGQpnUpdOmuQSfpV9MQO+/jo7r6yPbxT7CwRS5dcQPzUiuHLK9i
 nvjREdh84qycnx0/6dDroYhp0DFv4udxuAvt1h4wGwTPRQZerSm4xaYegEFusyhbZrI0U9tJ
 B8WrhBLXDiYlyJT6zOV2yZFuW47VrLsjYnHwn27hmxTC/7tvG3euCklmkn9Sl9IAKFu29RSo
 d5bD8kMSCYsTqtTfT6W4A3qHGvIDta3ptLYpIAOD2sY3GYq2nf3Bbzx81wZK14JdDDHUX2Rs
 6+ahAA==
In-Reply-To: <20250214192210.work.253-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14/02/2025 7:22 pm, Kees Cook wrote:
> diff --git a/arch/x86/include/asm/cfi.h b/arch/x86/include/asm/cfi.h
> index ef5e0a698253..dfa2ba4cceca 100644
> --- a/arch/x86/include/asm/cfi.h
> +++ b/arch/x86/include/asm/cfi.h
> @@ -93,7 +93,7 @@
>   *
>   */
>  enum cfi_mode {
> -	CFI_AUTO,	/* FineIBT if hardware has IBT, otherwise kCFI */
> +	CFI_AUTO,	/* FineIBT if hardware has IBT, FRED, and XOM */

You discuss XOM in the commit message, but there's no check ...

>  	CFI_OFF,	/* Taditional / IBT depending on .config */
>  	CFI_KCFI,	/* Optionally CALL_PADDING, IBT, RETPOLINE */
>  	CFI_FINEIBT,	/* see arch/x86/kernel/alternative.c */
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 97422292b609..acc12a6efc18 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -1323,7 +1323,9 @@ static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
>  
>  	if (cfi_mode == CFI_AUTO) {
>  		cfi_mode = CFI_KCFI;
> -		if (HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT))
> +		/* FineIBT requires IBT and will only be safe with FRED */
> +		if (HAS_KERNEL_IBT && cpu_feature_enabled(X86_FEATURE_IBT) &&
> +		    cpu_feature_enabled(X86_FEATURE_FRED))

... here.

Is this meant to be "/* TODO: wire up XOM */" or is that accounted for
somewhere else?


Also, while I hate to come back and contradict myself from earlier...

Architecturally, FineIBT without FRED seems to be no improvement over
simple IBT.  (I'd love to find some way of hardening the entrypoints,
but I can't see a robust way of doing so.)

However, micro-architecturally, FineIBT is still far better than simple
IBT for speculation issue, seeing as Intel keep on staunchly refusing to
turn off the indirect predictors by default like AMD do.

A security conscious user ought to be using FineIBT for this, given a
choice, even if it's not perfect in other regards.

~Andrew

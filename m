Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0AE17BA6
	for <linux-hardening@vger.kernel.org>; Sat,  1 Jun 2024 07:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717226854; cv=none; b=nJrnwjcin71AK+d9gtr8KzKyRuc3gxw/gif4JscBhmlGOc/1x+x53FaNX21qD25F8syzHcF3pisdxklWurOf4eniqe8Oho+rYcaSxVu0Ro549YHHs5NRDIg5rCs3C38FhvhGy6BK3CXpvO7XfgkqxoG/pjTJFb2oyHZVbdTRX6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717226854; c=relaxed/simple;
	bh=PCJyMuyEUt6FOSKpRSAJIF1DJ6gHGxPxtSzQDAWBqFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qClGLtp5mYVW8YxfIToVb762WHi8cmohgsK7m6EOPF87xnNsTMyx3hglvv6mLbrpUlR13EQk0F6bpF8aXp6BFYSodNAmP2DjWeGptry1QjtIXKuJpxcheY75qULs8zZeY9VnjB0/z89znAIZgmnlfjNOv7NDtQTRYQtXIIuhEBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bG+5p/3v; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bG+5p/3v"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e974862b00so29805951fa.0
        for <linux-hardening@vger.kernel.org>; Sat, 01 Jun 2024 00:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717226850; x=1717831650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hge4VyxWituyIOOJfd321VcyqziYhhPj3o4Ih55xN00=;
        b=bG+5p/3vyb4go8ANYQmZhD5TOLvBKYOZtyna3vgPdFAicvteo9XLLhyqvcVEfExBcD
         B2Hphqk7brJzIaUXkIJkymckLcBMIzxZWmeo7Q3LFFnkrZ5EGNzEczwBkrnWWxpRAOv7
         nIF3kci1SwqPE0lruSFN6mmekFJ1SDeEvoO77rNAyV5aa/d8bzLVOT2av2RqHAXuzH+T
         tAlMETqBrMLWoqwYofytlpbcK8Dt2NAPIaNMrsWsUYlIGJbi3rcCsDXWnqGTSDAeQOFz
         2KiZXj0wTSiQQwoQtQy+PB/BM/QDDxQUwbMwBkxGOBZ/r1N1P2dKpdAI0+fVDy7Mts1n
         20Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717226850; x=1717831650;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hge4VyxWituyIOOJfd321VcyqziYhhPj3o4Ih55xN00=;
        b=JTWaiW2bs7qA4La/X2MrNYrefItwlEZZaE55aMqAS95CuLqOeOtgH+iP3UZyyrEW1O
         GzOQrKeQ7DFwRs5/qs/2YunJg2y5alHkzNZiHP5fm6YOo6EJiBnKquBaGXabSuKr1Sg4
         6GqbySvNG/6VOEgkdmxLdE+bL5OCAP5U/D8rOrUlsd8Vu0XXppHGpo5H4sMJpfDoUIbW
         sot4Oq0j5AJ8yz8tzeIivK4IEZU0eb3n0WF7oLE2bxBf62mlSizyKH46l628Lz/J1alQ
         CGgdqRQuC+788oDi6T65CnuyIEo3DalAWmWXgf5sF1PFOGfAuBzWq1fdeWTHCOUw3d78
         d6CQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwmetbn4/exIjbpc8IJDYtzVs2RcNebDe4CwQMx34PBFLcQgTkb/d+LKklNlcVZjezCZG3MvNghYWqMgTXuBU9rq3OkSHaRecsZab8JU0t
X-Gm-Message-State: AOJu0YxBT8D7uVAxk4C+10TxY0yqLOfYmbKwgRlG72J9HqWT4RawOJr5
	w+LJWognw4oQeqONs4KvXfoqGshnVDVdgVm7bR5IyHJwVg/0i3eWTtZpEXWO/v0=
X-Google-Smtp-Source: AGHT+IGNPhItELQLzA+6LD+5jArBZ6BmBN1IYQZrt8rOBPmW+ThPAYNFbxwNdlDHZheUKtu5Am8cBg==
X-Received: by 2002:a2e:6a19:0:b0:2df:b7cf:9607 with SMTP id 38308e7fff4ca-2ea95114215mr28008081fa.22.1717226850126;
        Sat, 01 Jun 2024 00:27:30 -0700 (PDT)
Received: from ?IPV6:2a10:bac0:b000:5de0:5af9:fc8:27d7:ba3d? ([2a10:bac0:b000:5de0:5af9:fc8:27d7:ba3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b838b4asm46873915e9.6.2024.06.01.00.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jun 2024 00:27:29 -0700 (PDT)
Message-ID: <a54db95c-e22a-4e13-ae4b-6a5a67d1c49b@suse.com>
Date: Sat, 1 Jun 2024 10:27:28 +0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/boot: add prototype for __fortify_panic()
To: Kees Cook <kees@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <20240529-fortify_panic-v1-1-9923d5c77657@quicinc.com>
 <0d3f7c58-7fc0-4e8b-b6fb-c4d0d9969ce7@suse.com>
 <e42c4984-d4a2-45b1-b93d-7471000766b7@quicinc.com>
 <202405310923.78257B2B3@keescook>
Content-Language: en-US
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <202405310923.78257B2B3@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 31.05.24 г. 19:28 ч., Kees Cook wrote:
> On Thu, May 30, 2024 at 09:23:36AM -0700, Jeff Johnson wrote:
>> On 5/30/2024 8:42 AM, Nikolay Borisov wrote:
>>>
>>>
>>> On 29.05.24 г. 21:09 ч., Jeff Johnson wrote:
>>>> As discussed in [1] add a prototype for __fortify_panic() to fix the
>>>> 'make W=1 C=1' warning:
>>>>
>>>> arch/x86/boot/compressed/misc.c:535:6: warning: symbol '__fortify_panic' was not declared. Should it be static?
>>>
>>> Actually doesn't it make sense to have this defined under ../string.h ?
>>> Actually given that we don't have any string fortification under the
>>> boot/  why have the fortify _* functions at all ?
>>
>> I'll let Kees answer these questions since I just took guidance from him :)
> 
> Ah-ha, I see what's happening. When not built with
> CONFIG_FORTIFY_SOURCE, fortify-string.h isn't included. But since misc.c
> has the function definition, we get a warning that the function
> declaration was never seen. This is likely the better solution:

fortify-strings.h is used in include/linux/string.h. However all the 
files in the decompressor are using a local copy of string.h and not the 
kernel-wide. When pre-processing misc.c with FORTIFY_SOURCE enabled 
here's the status:

$ grep -i fortify  arch/x86/boot/compressed/misc.i
void __fortify_panic(const u8 reason, size_t avail, size_t size)

It seems the decompressor is not using fortify-string at all because 
it's not using the global string.h ?



> 
> 
> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> index b70e4a21c15f..3f21a5e218f8 100644
> --- a/arch/x86/boot/compressed/misc.c
> +++ b/arch/x86/boot/compressed/misc.c
> @@ -532,7 +532,9 @@ asmlinkage __visible void *extract_kernel(void *rmode, unsigned char *output)
>   	return output + entry_offset;
>   }
>   
> +#ifdef CONFIG_FORTIFY_SOURCE
>   void __fortify_panic(const u8 reason, size_t avail, size_t size)
>   {
>   	error("detected buffer overflow");
>   }
> +#endif
> 
> 
> Jeff, can you test this? (I still haven't been able to reproduce the
> warning.)
> 

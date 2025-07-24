Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA87486328
	for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 22:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753395520; cv=none; b=ROA8+tIy6TethtIgvFc4zydWGjbRBXoWZHmDCcVDAiNQWcCL1GK1Xup4dQRl0P1jiZB6TptkDnKyXJpxIIu07X0p6ZyFvek4tq4bBFmXRtwCcgwuEO1DTuKInSCUxPeSLTmhet8tx637rF416/4cCgqSItU17bUIlgBRSqugc7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753395520; c=relaxed/simple;
	bh=0QvT3CUkJ6EXgG4xBXsmRtKHHlBw+oanIFcCij4kAHM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sJ1SdoawhvDPD+Jwe342QzHLF599YgiVM4HibS7+2LLWfCM9+qfMOfVXA70LQ5rosUolMuUg9v+0/Nxwfw+jejhn4rVF0HJlDRvqwg5HJ+gfxT4Iq2fo2t9JoE2h8E0sosYNeEBatRWw1YpHbtMZsGX7qMdkOxz6DopmQo3sscg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CVMjbcHI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVMjbcHI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753395517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=o3Ts71k9kWEbm+9MEFacjDKvVlaJ/u4GBTuIh+m8AWw=;
	b=CVMjbcHIvH8197HtUdst0jw4c3e03WMbrG5PsNj205xdtiSHcusE3iWPIyg2TcEYtLni1T
	cI0GA1ogDWpJV3Rjcm7mUA+f30QJBGA7lHug854+j/RylRbL/VBGFe1RU6eUIfqTCYggW1
	tGYxUbWZCJy+ZIBIoWqGk0GooLYq/XE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-pDahH7pcMXKUjdl5dgUKAA-1; Thu, 24 Jul 2025 18:18:36 -0400
X-MC-Unique: pDahH7pcMXKUjdl5dgUKAA-1
X-Mimecast-MFC-AGG-ID: pDahH7pcMXKUjdl5dgUKAA_1753395515
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4edf5bb4dso908978f8f.0
        for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 15:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753395515; x=1754000315;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o3Ts71k9kWEbm+9MEFacjDKvVlaJ/u4GBTuIh+m8AWw=;
        b=d4czs2JT2e296fAhehK3l7PWgqX5ZOcA6/BpZURujwiqVU5h+/igxlw2WRUNfT86Xz
         gNBKks6X6nJm34TrGXEuK0BFX+kegnivC8aRDY2wa3qLp8xeRFUBpuhYxzf32ZLtMMid
         pq4KqEm4t2R9rGIayV7/PEqbk0zCfVjzKtwgE1Ab+Q8jZ8ZZ0vUiJKfnymK7WKti/Kso
         V/dshsjw+8/L4p7bJXCKdn2Cd8NEnoe9w2WsS15PzXK2+524kaWexvFot99SV2QuRnB0
         LOmazzNHBaiVBskux1xKSyxJZTQij2dKSZ2TfUJ+lMQT8TVYYu/uy1wRgwh35tolMLZz
         9gfg==
X-Forwarded-Encrypted: i=1; AJvYcCWLwSU+0LFaX59cWKlftjHBD8cQ713IdhJRd29VxngOEyLnCLJQiTpC/OGuKGzo04WMAsydFl+mVOwNmF/rQJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YymNanPjg3sZ8V6pxBGxphC9u+c5muShU9r1SV7pZPQvSONMeEg
	CheXHr4EWVV67qkhBgCGRuS/cSCqt4c/5dcL6U333umCGrqIyOWTFqmfaCXwZb1WMNNZObe5E6W
	Kp6wl8VGjhcKa0mt2bZcafacCVSfb8lI2SoXfEyVQoRju2deMSOELlkzGjm5w5txzOzlCyA==
X-Gm-Gg: ASbGnctN9pLvhUnRUU+3X17Yk+cI6aKquPPLFsYQeyz9/INNzfAFO/zwbhT71iEYZY7
	9qzseEQL035AYV5dU8xlotkytpgBnWQ2GgeztZuZy3Dj9gFYb9eStZpaRUrt9rfTg+bUHjMi9Bw
	9XdcsAHbC3tFQ26kdUu68doFYFTvssQA0THCdXra59dx0lkUJ3B5lk5FjpH39h1kRqNS/SSTvTS
	25ip8/sRcw8Ef5Oh1fvwFahNEMymENk3QL2Uk1Wiuxh9A+XKpWlOg5ONbGYZlgk1I3wc+yBXu+A
	IAqsxSgitrxpTrfpiRZNYpLBg+QPkaxFDCQDkg1R9/CgoOSHVOGQ886bghX9ycR82w2sSmB1CPf
	kEiMfDrl7/zQ53krD1eDVp6HdLuMz470qwKiLKviVnbsp8oXWaWOpbGhCJ2A04oseD3w=
X-Received: by 2002:a05:6000:4382:b0:3b7:5985:51f with SMTP id ffacd0b85a97d-3b768f060d3mr7168777f8f.44.1753395514939;
        Thu, 24 Jul 2025 15:18:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEW9Oz0ofFy+ZXrphC7SrO746cspr60p4D8s06ek8+rLNxlA04Z1UWxrgzuJqYYf4J4/s1SJQ==
X-Received: by 2002:a05:6000:4382:b0:3b7:5985:51f with SMTP id ffacd0b85a97d-3b768f060d3mr7168766f8f.44.1753395514391;
        Thu, 24 Jul 2025 15:18:34 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f01:5500:ba83:3fd7:6836:62f6? (p200300d82f015500ba833fd7683662f6.dip0.t-ipconnect.de. [2003:d8:2f01:5500:ba83:3fd7:6836:62f6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705684a8sm32671285e9.26.2025.07.24.15.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 15:18:32 -0700 (PDT)
Message-ID: <1bc456a4-30ac-4e6b-8830-e7c86f113f9f@redhat.com>
Date: Fri, 25 Jul 2025 00:18:31 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] mm/mseal: update madvise() logic
From: David Hildenbrand <david@redhat.com>
To: Jeff Xu <jeffxu@chromium.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
 linux-hardening@vger.kernel.org
References: <cover.1752687069.git.lorenzo.stoakes@oracle.com>
 <ec480dc1fd4ce04bb11c0acac6c6da78dc6f4156.1752687069.git.lorenzo.stoakes@oracle.com>
 <CABi2SkU75e7tXcpgnLbDhqSJBWVPOvmfMh2uPsU3mUjMUhhYqw@mail.gmail.com>
 <ab45d2f2-a34e-4ec7-8a49-03d166e6215a@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <ab45d2f2-a34e-4ec7-8a49-03d166e6215a@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NGCa0jAe69rrGPa-AQMA698qEfnKaq9aVnmPzdz-z3k_1753395515
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.07.25 20:56, David Hildenbrand wrote:
>>
>> To summarize all the discussion points so far:
>> 1. It's questionable behavior for madvise to allow destructive
>> behavior for read-only anonymous mappings, regardless of mseal state.
>   > 2. We could potentially fix point 1 within madvise itself, without>
> involving mseal, as Linus desires.
> 
> IIUC: disallow madvise(MADV_DONTNEED) without PROT_WRITE.
> 
> I am 99.99999% sure that that would break user case, unfortunately.
> 
>> 3. Android userspace uses destructive madvise to free up RAM, but I
>> need to take a closer look at the patterns and usage to understand why
>> they do that.
> 
> I am shocked that you question why they would use MADV_DONTNEED instead
> of ...
> 
>   > 4. We could ask applications to switch to non-destructive madvise,>
> like MADV_COLD or MADV_PAGEOUT. Or, another option is that we could
>> switch the kernel to use non-destructive madvise implicitly for
>> destructive madvise in suitable situations.
> 
> ... MADV_COLD / MADV_PAGEOUT.
> 
> I am also shocked that you think asking apps to switch would not make us
> break user space.
 > >> 5. We could investigate more based on vma->anon_vma
> 
> Or we do what sealing is supposed to do.

Sorry for the rather hard replies, I was not understanding at all what 
you were getting at really.

> 
> With the hope that this sealing fix here would not break user space.

Is your concern that something (in Chrome?) would be relying on 
MADV_DONTNEED working in case we had a MAP_PRIVATE R/O file mapping?

Again, disallowing that completely (even without mseal()) would break 
user space, I am very sure.

Whether we should allow zapping *anonymous folios* in MAP_PRIVATE R/O 
file mapping is a good  question, hard to tell if that would break anything.

For zapping *anonymous folios* in MAP_PRIVATE R/O anon mappings, I am 
sure there are use cases around userfaultfd, I'm afraid ...

-- 
Cheers,

David / dhildenb


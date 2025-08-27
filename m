Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46291C6BE;
	Wed, 27 Aug 2025 01:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756257849; cv=none; b=bQG7ORd2vOTkq8xTbbQfYPZQh5BBzU5W/M9aIgGnJTH9Q63IAgIJo/K/D3vgaKcPMUKaJYD22XFJWNIrT3pPD/FAgD9vgKp+Qa/64tG14F8DKVTRVQ0Kd+nNEMbjiWRmX9V7fQnQP21YVF+NgAEJiffnp3gN1LVeiT6bTRp1j9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756257849; c=relaxed/simple;
	bh=cXUS/kvVhOUOcLsbWaSwcJZhQCt+40+ooC5644ukd5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlrBNPlhB6sxfuxCuDv6mc3lWCbfSrzjr+86h8zWkd56yBlXQjJA28nw1t67hFcP9MoX9tLnYEz8SvjxVmtQzUpt2/HztncybttOsUTU2l1w51cMww7Yz/op0pZXEgNUSiFb2UIolel/7RQoDXHbfL/6162rmEe2FhekC99FdMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWK2v8FI; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWK2v8FI"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-771e987b4e6so2242700b3a.2;
        Tue, 26 Aug 2025 18:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756257847; x=1756862647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m1eN+RfkD/BZr7YKYuoHDKX/GqHENJ8RA/tRnRlLGTs=;
        b=IWK2v8FIYU4Nh9u64xU0ZFaDfYzXpXLbHUAKg1qJZyW0cF+dtbZHQOQxEowNtBT+R7
         Ar1sHjhYSlwWGmZFiXRsUzmen1Ckkso0VogCzYk2LdvcNOVJhsqnzpQvkTCeOsdW7SgB
         9DkjZ/6gaeLexgSJ7bRD/Q+EZunJXITpOXwGBGT7dAg8DIfsbFxkrHUivyFLdniRubnN
         pI0zVp6hKCU+deceJNfnwbxBevlbaBiSpYgpdjh4Ftj81KTVKML+lAbdjTlAylr+M/IM
         uMxHF2SfNFnXnsCqK61yM5+qk1IXvrK1+bmJDYbOUbt5kQb0nY6L6IUPLYbLoR5DDLVF
         kUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756257847; x=1756862647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1eN+RfkD/BZr7YKYuoHDKX/GqHENJ8RA/tRnRlLGTs=;
        b=L6m2HMqGUru0Gcbpzbxv94EfdG29Yg5tp7J+S/MYq5VA9j9K5p7dSDaNgGSYoVBwoq
         na9F382LraBTkhiGJJLEBljaTEMJFAMi919R01vmONxNh4oj/dqoVACCUj3jswXQBOYz
         ZXL83MhS/0DcvkXyGTDHy7Hnn5QGKwDNZfnmSgV5PeqXUMKoGI8mkVIWc+cx6i+sCTd6
         CifDsqUP7imqkNOcL4VQjinNw7w5nY8dRAPAFMyLMHtYIjpmXxG5oTebuTlzELA2Msmo
         FSzRJ+75zCdOTHAllkA+UjuWX9BTgDymecGi58jbfQOqOM1NYs/9lHUGqpYXPsrHIb5n
         yl/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUssbVwxSvXkELsDmQwd/xokm7ZW0KUrku/pr3fSy7Z3MczZWgLjXX1+HtcYeq0JmuvC9l4RY1C8dF2ORzMqyA=@vger.kernel.org, AJvYcCVzKkNmaMZfnyfXiPL2a30E4iMAXIm50e3MOGeICJpCKWG4mHpxMzqBlskYi9tNChb8lU2WFg1ZqKSYBa5j@vger.kernel.org
X-Gm-Message-State: AOJu0YzsUqoE6HEBqiBXeIBNiL0f5Kucqfdyqrf2pokf7zprHZUzdAE8
	wmuXTTHj8QP+YzRRYOgXsWX15O4+VFIJ9VEYlhTxC9qwXME5pN8vhZhZ
X-Gm-Gg: ASbGncvF/2l/2caurWd4uHxSQH83z2YBZBPLpKZ1jvGFcjsJ02BOOUqV5sLZ8dB7xMx
	W3M7pLEkhdPQQVmroSUqxVHsF8wjH4SYadIfxMDeNGaR5OtFXOCcon+ywvrjxmJxpRqLRQ5SagJ
	Bbxi14Q3/K3eihomeOUD66wl8kokijwNMOVw0D9lnVEbbAqUa2q8QMqoamKcBFJym9BP/BjVovS
	zmXiSnNJTuRqlwplzISg3QTcAM2WKH5etlgr+WeHIxEcroX6BFG9zG0/ihlwbhI850GFA+fHrFD
	Tr+zNcV1qpCxju8tP0W2idSvUkC+Vm4MiOO0spEMnRVKqDF56Wbul80VC+k7LK67ZIp9sXZ7SN7
	cMybezLq+C13soI/BHQwi/P8yEPGwgwhf
X-Google-Smtp-Source: AGHT+IEh3XZg5923sDjlaQ2nPZzRtgxPNuzgkJG3sCz/aVnRUW5jNGD0fK3hayb5dgJOYYe/t1LQDw==
X-Received: by 2002:a05:6a20:2a29:b0:243:78c9:1631 with SMTP id adf61e73a8af0-24378c94b3dmr9318050637.51.1756257847131;
        Tue, 26 Aug 2025 18:24:07 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49d858ae34sm8328274a12.47.2025.08.26.18.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 18:24:06 -0700 (PDT)
Date: Tue, 26 Aug 2025 21:24:04 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: Rasmus Villemoes <ravi@prevas.dk>, kernel test robot <lkp@intel.com>,
	Vineet Gupta <vgupta@kernel.org>,
	linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] arc: Fix __fls() const-foldability via __builtin_clzl()
Message-ID: <aK5eNDa5H-PNGHpj@yury>
References: <20250826034354.work.684-kees@kernel.org>
 <87ldn644d0.fsf@prevas.dk>
 <202508260955.2DE50A3FB@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202508260955.2DE50A3FB@keescook>

On Tue, Aug 26, 2025 at 09:56:06AM -0700, Kees Cook wrote:
> On Tue, Aug 26, 2025 at 03:08:59PM +0200, Rasmus Villemoes wrote:
> > If __builtin_arc_fls() simply doesn't qualify for attr_const for
> > $reason, I think it would be good to have that documented in the commit
> > msg. If it does, I think a gcc ticket and link to that would be in order.
> 
> I already sent the patch to fix it. :)
> 
> https://gcc.gnu.org/pipermail/gcc-patches/2025-August/693273.html

I'm OK taking the patch if it fixes real problem for you, but it looks
more like a GCC problem, right? Is Clang also affected?

If, say, Clang is not affected, and you expect that newer GCC versions
will not be affected too, let's protect the new code with a proper
ifdefery, so that it will be easier to drop the workaround later?

Thanks,
Yury

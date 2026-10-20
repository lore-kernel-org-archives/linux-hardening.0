Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792515536;
	b=Tl87G+E8Kl5m0rF3sjOe1I8ZcU6tJOZsULbOpy1wfi1gPu1z6je1GcVeQahVmj/Y0bql
	 kIFuPg9jt1bOc5czTgPkDkDP88Y4USr4fd1KUfH0xN0YwHdwBaZS3NmY99ibPdmlWFyS6
	 ok+Y29HZ6FWl+3lrs1CoARsvoa2zeJ2MiX0NPuRcrdnawKb0i97//5BBH9pKKCsjJCszF
	 V1tpfr1h4/1lUOMd2rE+UuOaFCiS9Eo9MBCKAMGhOqb7euoJkiWRnE+jH+6eEuIKCP7iN
	 Gmr+QSvAfdy20tJNLlBpli0xdMrqguo2h2cgwbKTRcbSBsABsk11mdkkHAv4vb1YwCg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792515536;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=W3UZs72ItN8BjuPnBCdirt6JsCzxyYkOlT58mDePWJs=;
	b=3FF3O1U0HAqDRkvuqnE0WKw7UErD+tLnPg1RGdDAYLkfk11s5aiEisN2IwbgwAwvtHYl
	 ZasPHPO+9Tw9iI/JXobiCdumXkppuGpDbns8Cz7pARqzFzsv+UgzWWdXSasN/f3X64yXj
	 PVNvV8Zeheo0oE1v1tu8v3+EOdjNwFyDN2Ue/sxUM9oakabeWihif+u31H92yNh+MbRln
	 o/pOn/eu+Km3aDcuXb8SztPdv6DMXy1mt5Koti+X86W2mBaMoyBPWhZQFV9EeWkQuhqhC
	 w2T7qPvkBdABeAS4yeoNDvr3FuDATC6V+LQsyh6X/LehoL5URi4CbXrVjtHAYap2tQw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CJA16jB7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6FB606A319
	for <linux-hardening@vger.kernel.org>; Tue, 20 Oct 2026 16:58:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF6FB606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CJA16jB7
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6795df33283so500128d50.1
        for <linux-hardening@vger.kernel.org>; Tue, 20 Oct 2026 09:58:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792515535; cv=none;
        d=google.com; s=arc-20260327;
        b=GTOTrhTOIIJHHE4IHZTPTBDFB1h3dwNc19mRGNRUkETav42Kqao3+NRtjHXtH5+TZN
         HEke7EduRCM2ZnFENj4w1R3L/JiBPVKicDSGQ+IQGUL9NN/Q4maZ8FeFmAxLo/We5DkZ
         /UDkwx43TDmqZlOVJ5WiZkpD0gVgmZonLdvY/VWD5sSL7ubOZ9UUFkrQH5fPuKJNLGD0
         WcicsVxrZyn0ZECU4/fKSdVx7POIEUxbY6XZcpjPh2TCiLwrg0+UHUavWoYWDnlk5fp5
         m6Q1AnTE1QQjUfWxxvKNPE9TFh1nlcb3J6zDXUG6otlcXi9xU8pVKzwU57pHoWNk3DA3
         6Mzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=W3UZs72ItN8BjuPnBCdirt6JsCzxyYkOlT58mDePWJs=;
        fh=fyCJ3MZGJOTcFUJEO7XV8LrK/Ck1kqveGiZbQT/TFx0=;
        b=Xu6z+Xd7npCbHhcevztOpEulUuoTsZpCth3Ol6IepIWDy9VachNUS73fwmPrpXP0SU
         Bis+DYycnMaGIJk4ouInAsuCAfHjGXOmwsY3S+hKY5GAQPYb2Ya8wVkbC0vkgxi535sE
         HM4rqzbK66yoASjQLXA7UfChuo/iVU2fK+NeAWFyFzv1gUjMhluHasMZBde0MovdrtOH
         rh8aSZsbdWHIOaYsk2J6ZyO2YBc52b1ewmkj0wrmcHKcyd3kUOBMaUK/DoieUJtQRbyZ
         dQhgRuvcmcf3q1g6eMNhxkRWiEp0VpukM2ukcnN5+yQYMz1vDLyVN6n0MrVYiLRHmL0Y
         9iiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792515535; x=1793120335; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W3UZs72ItN8BjuPnBCdirt6JsCzxyYkOlT58mDePWJs=;
        b=CJA16jB7gWCpEr8AZzawOzxdJb4z/YFbC4DXOKSP80dkmRfx9QH9UfwmDDMEnx6xrY
         ytWQXNUpYR16zu6JxHLJT920ExBMXHtB22zguBiRyWPN5R/seJsI2ALDFelxA3RynBnk
         k6SaPDm2PQdU8eyNp2gGkRKCMQyWXvj5KMKc+T/kzKmDhI71TQ91IFPyIi48S1AlBFtP
         pUjYL29NSRsLrDoc6mMsS3vPR0p537pzITgbBc7WHOZrxaeMGGfzpqx+5A0fwKsXo4l6
         vGu4aZ/5UhxApp19j+gWVxlx/pBPcFlASON9y7t2DhHQt4/qBBperU87oPXQvmT53Rfr
         nKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792515535; x=1793120335;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W3UZs72ItN8BjuPnBCdirt6JsCzxyYkOlT58mDePWJs=;
        b=cLMCXwHG5/iCeqh8YJx5DkKvqw/bzr93HoDK8HwQr+orS5ubpwKUvrky0QFAqI6T8G
         QDTm2Uyzc2PNmYGYWcQ4R+1SC0IpbGcY4dU8olGJ3hpEmmrHZPnXR3Zd1ZCF05OGA2kd
         H2AygftjHWA71AO1bnEwE867m8p+b3v7RdsqwStQ5xC5WAEJxkMHgHhRE0O058OHbV4+
         R57mDmM5A4QjVu4+OUPTvrInEhpHbuPWZZSolI4BZSxT9rFbdEpPf6zkBT/PMzrvpXwd
         Tv8/6jtI5fIoPSgrVqgEBZVgYK9kXffXkclvmOMRE1FH+ZX3brz3i8OK4PrGevyjeCvd
         M+xg==
X-Forwarded-Encrypted: i=1; AKwUvBzWY7fo0J1xQvV7xHz1LUdXa6WKDL6UoOr2L1IsbIupyDu6yMRjfi9rwHtED3aPC3WhwcYivglGxmw7FUmoKXM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIG9wEF1L8YcmzJK2/+ptSQGfDzftIHIrb0AGoQ89n1Mh4dz6qG
	9l01NAobaY/usCLu/uRG1eDbewAs6UaPzGTNAmwHY4WmPckKsK8e5lzi9WQWHfCa69jpQvuFtdO
	59VFZYkLYVzHOlzV2dXiy+4QyeawzF6k=
X-Gm-Gg: AYBFou0x1HRvpLZsNYd1RY6WWUbI+xqKnjmAWuQnHhA8bkEactqTQoXwwvy5JT3LF3o
	oDaPFZX+i5iop9+wvd/w/STC5yCDJDDR6lD9wVE9JVGC2yBY0cfkZqX6Z4Iabi/5g1etPSySi6o
	GiItQX8vDPVCcmZRVioCH+D9HbCtezJVnBdBdYR+oBflkoxSyWXbS4RZHN85SWmNucNClGSDKwI
	rCpRj1D5a2ITP7rrlu6/YVyNvNuHDLu8YxxqlG1eVfVYzl4k8LXJ45USvPYRfWIZhRnKxCI62KV
	V1UExuABHRcM2B9So5xeGFD7btk1UotsmhZgL4Mzda1aHlYxuA2p/A==
X-Received: by 2002:a05:690e:138a:b0:679:b8df:29c with SMTP id
 956f58d0204a3-679ca54432bmr6769731d50.2.1792515534972; Tue, 20 Oct 2026
 09:58:54 -0700 (PDT)
Received: from 95991385052 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 20 Oct 2026 12:58:54 -0400
Received: from 95991385052 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 20 Oct 2026 12:58:54 -0400
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20261019-bug-word-at-a-time-zeropad-kasan-v1-1-f21a3ed6a477@gmail.com>
References: <20261019-bug-word-at-a-time-zeropad-kasan-v1-0-f21a3ed6a477@gmail.com>
 <20261019-bug-word-at-a-time-zeropad-kasan-v1-1-f21a3ed6a477@gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 20 Oct 2026 12:58:54 -0400
X-Gm-Features: AclHuK_J27k-o8Ui6g8e3q8L_DReW_3vhUszXOZ3Ua6MjDZ1MkwzX1wkuw839aA
Message-ID: <CAPAsAGyrH1quaLuyui6Qm5sokid8=yjNbAM3cOunynfPNQtfgg@mail.gmail.com>
Subject: Re: [PATCH 1/2] word-at-a-time: check the first byte in load_unaligned_zeropad()
To: Qiliang Yuan <odys.yuan@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, Marco Elver <elver@google.com>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, Kees Cook <kees@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	Peter Collingbourne <peter@pcc.me.uk>
Content-Type: text/plain; charset="UTF-8"

Qiliang Yuan <odys.yuan@gmail.com> writes:

>
> diff --git a/arch/arm/include/asm/word-at-a-time.h b/arch/arm/include/asm/word-at-a-time.h
> index 5023f98d8293d..f672aad2e30e6 100644
> --- a/arch/arm/include/asm/word-at-a-time.h
> +++ b/arch/arm/include/asm/word-at-a-time.h
> @@ -56,6 +56,9 @@ static inline unsigned long find_zero(unsigned long mask)
>  #include <asm-generic/word-at-a-time.h>
>  #endif
>
> +#include <linux/kasan-checks.h>
> +#include <linux/kcsan-checks.h>
> +
>  #ifdef CONFIG_DCACHE_WORD_ACCESS
>
>  /*
> @@ -69,6 +72,10 @@ static inline unsigned long load_unaligned_zeropad(const void *addr)
>  {
>  	unsigned long ret, tmp;
>
> +	/* open-coded instrument_read(addr, 1), as in read_word_at_a_time() */

Why it's open-coded ?

> +	kasan_check_read(addr, 1);
> +	kcsan_check_read(addr, 1);
> +
>  	/* Load word from unaligned pointer addr */
>  	asm(
>  	"1:	ldr	%0, [%2]\n"

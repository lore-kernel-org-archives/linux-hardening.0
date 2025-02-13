Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E11281345
	for <linux-hardening@vger.kernel.org>; Thu, 13 Feb 2025 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739456360; cv=none; b=LeP2KM7V0gwdaHwNmmkQNW9dPN3783GEMbLUfxKnVcFTbdIYCMnostGVl8HlvPkVi09Nv+zszfoA77HSWVKqBKxIatd5Zq5Ie8TK4cN9c+/YrG7yNjuXfkjzL34eQds17GsslffAyie1ARXAP2kAMSeDT9ku9uLMPXYh7YrKdNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739456360; c=relaxed/simple;
	bh=uvwW2M0tsg3X8YSCEGE1nEThdpnwA3AYKjZ9BOrjojg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fzRnh0RUtyOCcXRxZO+t5swE7MgvCkatnnaoAD0LuCFOKt/Hpa22nrtTMtBQ0pJQUIGnopdX4gE6rCKd/2Lg1k9AZn6brBVwXfbRc7mxkdB+D0zSP07qdZMfUrixTI3hOj6sCdZONb7oVTZ+nCJ4+oTYnclMVzOU/fzpFk1fK0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dVicuATO; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dVicuATO"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7270130a109so31191a34.3
        for <linux-hardening@vger.kernel.org>; Thu, 13 Feb 2025 06:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739456358; x=1740061158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvwW2M0tsg3X8YSCEGE1nEThdpnwA3AYKjZ9BOrjojg=;
        b=dVicuATO5+njIY76HlhFYIyH8Ag0TCxOkyXLTm/EAlw6tpMkpeEYidgNO+rT4gaqTL
         O4DZeIQg4YVPuqzB+1awXy++S6AmBtH+Lp9+1XEr35Px8h2EBFLvmVSej2YWUdiCDY3D
         rOK8JUCY1cgxZtfz3CDV8wtgBQPdP5MqOAAWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739456358; x=1740061158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvwW2M0tsg3X8YSCEGE1nEThdpnwA3AYKjZ9BOrjojg=;
        b=C5g/q4F5rqZJLbWhnX3IRU4UX9kRfu7w5YrhsvhlgMz8WQEa+j4My9z/AxjLbTwu3U
         Gk2bUVu9T2f+vIb7V26Sfzva8NJ50Eh1RYF0b6iZKnvxQ4hPCy0lQKWwbkb+GiyM33SS
         bnsr5eh1Dv4dGTmicbhT/kRRWar7yoDngbeibtbO9fzA57oXqL7pgNVvuWCkkm1govxx
         plf9qHIALm9odvJiBSgpwL4fNeYbcFWGjx0ZK7FdL2WI48gW8FLAdUFxTWuM6uwA0H6Y
         31DP0FYR5V0qNevV1ehATs3nd2lO10gE2qWjUex7DkfX2Xb2Qeex4LIOhedDlQpBEEcD
         PkSw==
X-Forwarded-Encrypted: i=1; AJvYcCWmoMXI7WvxS7161cqdbzf4NZ+tjYsUUquq26gWUualzh1csMbldVFv6PeVjyekzs/MESHb39gaWsFS4wgPeZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YykpAMhA2+GsO54lSXfcCrqLW3OKdp6fEauNigBhDaa7u7vJH8Y
	h64A4d29geK5s7m1y9dRN+HWwpUVLQ19mzQKSLVWMYdgoS1U+0YkVPvuu0xFBiqBHYhHQqISOqI
	0mVVAODEMj/NjzLVPoTRCZtE2AD+vxj/57Igu
X-Gm-Gg: ASbGncv3+e0ztF5njsHUsJPj2LLBOmHjxZVR0aO9IUfcpZD6SvXu5yIouerx76Y0dXy
	klH2H8jsxMnhX2+9Zkjnbgw2QB6ZSsc5S1GrY3k7hHV2wEfGCPJEzhk5DreY+J4AzCC8PkYadBF
	Z8NNt1sEn4ATEvuWp+77v/GcJYv67Ltw==
X-Google-Smtp-Source: AGHT+IEDqI9pfjnnU/sTPvTq6q4LFKcqw8kNwZAhOcRWyUEaa9UGeRzGdRy+xyqhMEsX8LjY+QmDAxL4M8xudw2I6rM=
X-Received: by 2002:a05:6830:488d:b0:71e:4ce2:4331 with SMTP id
 46e09a7af769-726f324c02dmr1708739a34.4.1739456357827; Thu, 13 Feb 2025
 06:19:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212032155.1276806-1-jeffxu@google.com> <b114f48a-a485-4ebd-9278-6c62a1f33d9c@lucifer.local>
In-Reply-To: <b114f48a-a485-4ebd-9278-6c62a1f33d9c@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 13 Feb 2025 06:19:06 -0800
X-Gm-Features: AWEUYZkh57X2nN0U81mtrUf8380_Mz2GDTsMAg8QIsAN8W21sRJ2eFLIaAt_1F8
Message-ID: <CABi2SkWbYpQsUUAukG1xCnX1FmZpr90r_LtKMrAji_HuB6E6zQ@mail.gmail.com>
Subject: Re: [RFC PATCH v5 0/7] mseal system mappings
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, 
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, hch@lst.de, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, 
	willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, 
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, 
	mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 3:24=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:

> It'd be nice to update the documentation to have a list of 'known
> problematic userland software with sealed VDSO' so we make people aware.
>
Sure. It will be added in the next version.

>
> And I _want the series to land_ :>) I suspect we're close now.
>
Thank you for reviewing the patch and giving support.

> I am tied up with a number of other tasks at the moment so apologies if I
> take a second to get back to this series, but just wanted to say thanks f=
or
> addressing my various points, and that I will definitely provide review
> (it's on the whiteboard, the only true guarantee I will do something :P).
>
> I will also come back to your testing series which I owe you review on,
> which is equally on the same whiteboard...
>
Thank you for the heads up.

-Jeff

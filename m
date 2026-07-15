Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD9B32ED21;
	Wed, 15 Jul 2026 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784133918; cv=none; b=unSL67by8MmLJ3S1cBwkLJ0Dflx4+eANg7k+uf2XH3DSWwHjewC2yNZ3Iio59mLCtBrhUvF7tL4YXY3hbEQVWHAWs0ueDtD4YQAvPILKUrRMZLtbHk7kulhIJIFGL2xRqtYbFp07DoAh/nYdNfnmC5eoNbKcvJZjC4HD+2hckfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784133918; c=relaxed/simple;
	bh=umP7WylTRyWxFxFv1eOKiIfxYGS354u0KWab0Y8GqYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=na4Yv6R3ce5f2LbiF9C2oLaJIsRkIc66qwuGFIzulO3JAx0ZKGEqW9j6kPmDyExrubofUiCvmmnLo14pDIInXPono/vBj/9HTVvNf8yPuYoUt+tMNrhChgSLFDWCKnejWKCmbWepIpOSUP/wdLqvdL989f83aWc2UvvDD1nga8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHgFBLoK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHgFBLoK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113851F00A3A;
	Wed, 15 Jul 2026 16:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784133917;
	bh=6liD7w9BIP02kaI4OLc655JWqWM1N/j7Ocx9ZTgpKXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lHgFBLoK34HvyE6vYN3kFmgJxkVSHuQV8pIeWmKb2XpgDbNjCPGQCCIL85PKweLpM
	 msIQJOTq9jm+w48OQcp6Dk/QCPAxVLJ7Qn+h22RF0dZfd6KtGm/GcIue9h9ld15avn
	 O4fSpLF2lehl1ge/76Gba6dhrZcpNDySeVKH/sO9GNZXssiYMT4rjLDIzXQo3jpGNZ
	 huNI4eO9U1fIglYAPxzV+TXwwqyTuB4qLOnkhkjWy0oZiVAPddd32Utp/hCcMngWPM
	 fmBMXRcUpiJiXih2ZsPbqGlic1E3tg5NUIjePkKNd13M0Mg7fHu3D5REe4cqvaVwYK
	 QJ8ZVjvPFJt9w==
Date: Wed, 15 Jul 2026 09:45:16 -0700
From: Kees Cook <kees@kernel.org>
To: Ian Bridges <icb@fastmail.org>
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/generic: Replace strlcat() with strscpy()
Message-ID: <202607150944.0EDBF2874@keescook>
References: <alaPxW5S5PT_-kZi@dev>
 <87o6g8y9f3.wl-tiwai@suse.de>
 <ale0bq8DSefjWC3P@dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ale0bq8DSefjWC3P@dev>

On Wed, Jul 15, 2026 at 11:25:18AM -0500, Ian Bridges wrote:
> A seq_buf conversion would also be possible.

I think this is the right approach. The string/length is passed around
as arguments already, so switching that to seq_buf would mean all the
users of those arg wouldn't have to do their own bounds checking, etc.

-- 
Kees Cook

Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DC4288528
	for <linux-hardening@vger.kernel.org>; Fri, 15 Aug 2025 11:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755258063; cv=none; b=GTIW/zXzcDvggiyQ+nkE8K9Kdn6O/IXKzojHOsF1V/s5xhCIM8c6qTUI9okSqnbXUjJnaFdJBscKsAam5JUeNyU1coUfIA8fd5JN/bgVtXL7YhRJzn/V/GDzXmsawDXJKKZ4dcb7bBpTgEHZagymXK/Ser5PiZqHIZ4P06gX0n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755258063; c=relaxed/simple;
	bh=AgGFqXqrJ/VhBFHuGF8h1y5X7Jyy+ypna8Zk7EKgm3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TU5/3zNnBkalj/VM0l5EwF0JRbnzq1Tnc/G+8m6i8VUeXB7jNpfMx9D0Rm177WVBsVLk3mr9HhpYD0BC2fQxVRnYpObaPRqjIYac1McVcOMCjckSOkPHUPFobC0tAftG+fWtcSk0pGWLfI5DVVONbpsiOCGXzDguC2716gBMfkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=NQk1pLDQ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="NQk1pLDQ"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b9d41bfa35so1572390f8f.0
        for <linux-hardening@vger.kernel.org>; Fri, 15 Aug 2025 04:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755258060; x=1755862860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AgGFqXqrJ/VhBFHuGF8h1y5X7Jyy+ypna8Zk7EKgm3A=;
        b=NQk1pLDQyDRXY67LVGOcER/4j6syqY9DMq7WCVAveye6pKu9KememyJtwgXXZNYs0h
         tvjtTVszpLKd3Lep+p5m3D/J0HzjmEFHRFUFpLHh1boXFXpy3JeS3DmTgWTcMAzd/3FE
         otMKeXgRwWmLNbFvg7k3dr96mOGxyZH+ZzOjyuTKMcPZth1uU7S06JFs1f59BRhzEtmg
         n670J8vXWgLhS+ryD33m0Ak6Ste3BbR33G0O79MV/Ck5XKnBthS90YUDzjarirrFFbBP
         9xFgHVp9/xGM/ii4NW84OElmsDS+AqjMdMlMXc0d9MZkiIaNNYhxodydzE7NBA/QDqN3
         qKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755258060; x=1755862860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AgGFqXqrJ/VhBFHuGF8h1y5X7Jyy+ypna8Zk7EKgm3A=;
        b=k0brFoMXHivvRbBeLo+TkLdZpOqk5X641xngZNSc6Ipd85Hn0Wk9zpA//BkWAYg9vC
         YPUCl/AsYijDCU6Ht8rP/IRFRZidbaAITQzzZV8bhC3jjruvgXl3vWnQbuKiOvPiFJGA
         oW3r+3OSFjmU3Nh8grbcs3k3H7QRHWEDJjVLHMSSg9W5/e+feU2E/Q9MQlLgpvv3HkUc
         S8PZ8bXbkPj48zxKyUDkFiLYMz9oJsN9KF/NxCA+6FweMXad5cJobLUzDP8pUABITOdg
         vyoY0ksg7/sr21Rw+ydU5dufixRoRccqwdmxZvSRil5LFKV+xG8YI1hMJnvFimnZp60G
         8Gxg==
X-Forwarded-Encrypted: i=1; AJvYcCVX5fv79csdqqXNZ18gU884kWGEviu40CVIIvKBrcHLIl54l2Bq7X5XAUtw/GP2UxM99c3tuZro2vj6nMDRh6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP1HjGjINFk29pLVNwK7igi5365XoHxwxfYZoM0ZSvtl59C9ID
	gD7KqvJAOqUVfisOJc/u4vLw63aV6YMXKOwwMRBTjat+PihPq5fWram8ZPCl44pW4aw=
X-Gm-Gg: ASbGncuqMDTqKERAQNSfYFXZr66KyFbqZRe0CcLj2CEKI9wb1N0k/MQCXFl2zX1RsiW
	RUBtWOvCrj5DtOA2DcqdEY0uwNRIikEbMVF77wxJt/NgPF8U76ETDmC14GApe19g8AkZhdnEFrx
	wyCCTPAz5gOB5hRCW+3V9I+4DhrNkoPtiGRwonB1IA8mFh+iX4yOkTP/qU6d5ip5KMCeTDm+e4l
	dCm/hp74ZLaEFbJg5/Qpe6hGZdiEDZer++LWAfBBZuUcIy7Y+6/WEkspiTU90x4pyCwR2YVtz2M
	a0nnScUwaSOaPWhYY8JvTVCvgKxdH+s4VaHu7xTVDQdVXUu9Vmn5lomFXmWj+PHrtzr5Lno7uyZ
	SWStsqunI+sYodJTevnExsTmKRAE4Tt/TET92p58ISBp0GagcG1bsIQjlixJ5V8OxG+YAKv3tkg
	CCPgKVX82j7ZtaZP5R
X-Google-Smtp-Source: AGHT+IEZLgCHpz2MKgcW37YJtcjLjMyMA+YA7eK+FAPxHUA+IxdCMDYin/UkgjRqTGXMK5VFnVqjvA==
X-Received: by 2002:a5d:5887:0:b0:3b9:15eb:6464 with SMTP id ffacd0b85a97d-3bb66f11537mr1399812f8f.15.1755258059879;
        Fri, 15 Aug 2025 04:40:59 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb6816ef48sm1607789f8f.58.2025.08.15.04.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 04:40:59 -0700 (PDT)
Date: Fri, 15 Aug 2025 12:40:57 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Nir Lichtman <nir@lichtman.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	linux-hardening@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] kdb: Replace deprecated strcpy() with strscpy() and
 memcpy()
Message-ID: <aJ8cyXzMaa9b7ppN@aspen.lan>
References: <20250814220130.281187-2-thorsten.blum@linux.dev>
 <aJ72XZ0VkrCkKFNy@aspen.lan>
 <710CDE93-89CC-4B60-A582-5F9B2916ED72@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <710CDE93-89CC-4B60-A582-5F9B2916ED72@linux.dev>

On Fri, Aug 15, 2025 at 01:28:01PM +0200, Thorsten Blum wrote:
> Hi Daniel,
>
> > On 15. Aug 2025, at 10:57, Daniel Thompson wrote:
> > Sorry but a strscpy() where the length of the destination buffer has
> > been calculated from the source string is way too much of a red flag
> > for me.
> >
> > Put another way if there are "no functional changes intended" then there
> > cannot possibly be any security benefit from replacing the "unsafe"
> > strcpy() with the "safe" strscpy(). Likewise abusing the destination
> > length argument to truncate a string makes the code shorter but *not*
> > clearer because it's too easy to misread.
>
> Deliberately truncating the source using strscpy() is a valid use case.
> strscpy() allows the size argument to be smaller than the destination
> buffer, so this is an intended use of the size argument, not an abuse.

Sorry, I didn't phrase that especially well. I regard the abuse to be
deriving the length of the destination buffer exclusively from the
state of the source buffer.

As mentioned, it would be much cleaner to eliminate the string copy entirely
than to translate it into something so similar to the original strcpy().


Daniel.

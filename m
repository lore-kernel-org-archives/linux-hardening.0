Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E47D19B5A3;
	Tue, 25 Feb 2025 20:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740514223; cv=none; b=VV7JHWgNrjnzvkxa0kIUjpw2LpoeDO8vEUoZVuEt+yizf0Jmx0Z5lYZVaY+W66CMkBuUuD+ngSbUNUR3JKiiqiS+CPvXrZO2P7Ge8cI8QALk0YDEvvPOa4P01Le/s6d/26zwiE3UBAjdTS+N0wgBkxXUTxrw5O3y/wt0fy+olnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740514223; c=relaxed/simple;
	bh=9Sikho32R619XOFYLt/q+5TkXxnLWtEEZEAnylAOoGs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ewzLvcPsCuWfVu914tC3vS89s7oPdMziEQjy7nJnV3B50JPiyr6Z3qLszkX4Y0vVLhgICJFuWTuVqY9Dx8eg9IPjhJbUvny7TO1ga6ZG9aEgZdHgLmvZTJyVm/tGaSO4OL+B5VZ3TcevwPoT1V4HG+Kw0F8L3srGZW2GKlhHCKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=obGn1mYL; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="obGn1mYL"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2FE5748EC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1740514220; bh=slRgZF0YUGBpz++3WDLE3bOeRLCVZObJIeYEzYOIpCc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=obGn1mYLsYj0Td+2DDjCeU5YLxeiAW2kMrjnQxi7v/Wa4GRvnuTSspJUZnShbImxB
	 Q2SkDVdcrD9X9ivjbPRE6P6QSc952yqQ9o70c4hP1+zQRyCF6cGk7ptjQsBKJY1nX9
	 /A0pi3oHnK9cJQmdIw+g19qkIHirm/++2WQHG0BJCjip93wmVmvb1uxKORgw7gfaWZ
	 95Pmz7+UGqG58IBC1Xn5zg+PTTyAdenWFvaQEzds/tf/7IGuzgdJmvrRDKdkMy3i6Y
	 RFXDlXlkgIQV4HPWHS3UqrsYAaJuj1qzsikZcAzM/ODaYRM96mSmuMkoLOGXKi73l/
	 SDUVGmKvSErRg==
Received: from localhost (unknown [IPv6:2601:280:4600:2d7f::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 2FE5748EC1;
	Tue, 25 Feb 2025 20:10:20 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/39] scripts/kernel-doc.py: add a Python parser
In-Reply-To: <20250225083814.51975742@foz.lan>
References: <cover.1740387599.git.mchehab+huawei@kernel.org>
 <3905b7386d5f1bfa76639cdf1108a46f0bccbbea.1740387599.git.mchehab+huawei@kernel.org>
 <87v7sy29rh.fsf@trenco.lwn.net> <20250225083814.51975742@foz.lan>
Date: Tue, 25 Feb 2025 13:10:19 -0700
Message-ID: <87tt8hyedw.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> Em Mon, 24 Feb 2025 16:38:58 -0700
> Jonathan Corbet <corbet@lwn.net> escreveu:
>
>> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
>>=20
>>=20
>> I also think you should give consideration to preserving the other
>> copyright notices in the Perl version.  A language translation doesn't
>> remove existing copyrights...who knows how much creativity went into
>> some of those regexes?
>
> Makes sense, but the copyrights at kernel-doc.pl:
>
> 	## Copyright (c) 1998 Michael Zucchi, All Rights Reserved        ##
> 	## Copyright (C) 2000, 1  Tim Waugh <twaugh@redhat.com>          ##
> 	## Copyright (C) 2001  Simon Huggins                             ##
> 	## Copyright (C) 2005-2012  Randy Dunlap                         ##
> 	## Copyright (C) 2012  Dan Luedtke                               ##
> 	##                                                               ##
> 	## #define enhancements by Armin Kuster <akuster@mvista.com>     ##
> 	## Copyright (c) 2000 MontaVista Software, Inc.                  ##
> 	#
> 	# Copyright (C) 2022 Tomasz Warnie=C5=82=C5=82o (POD)
>
> Also doesn't preserve all copyrights from people that worked hard to
> maintain it all over those years.

Agreed ... and I'm not sure what we can do about that.  But *removing*
existing copyright notices is a bit of a different story; that is
generally considered to be fairly bad form.

I don't have a problem with adding a longer credits area, I guess, if we
want to do that (though it's not normal for other source files).  But
I'm not sure we need to.

Thanks,

jon

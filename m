Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117171DD0D4;
	Wed,  7 May 2025 05:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746594038; cv=none; b=i1lFrH5l1AiqlMBCV9N+XOfzE6z5xN/pIAq1KKF058Mbuk+0UZQ7Fh/eV7Xvl5pRxgjoL3fKhI0YrqtBhmBWVWg94ik98cOEcog669XZTIgVnlP4Gjg7D34LUUiZHO/q6U8vUh7Ohw3R5BtMB3uzZWfZnya05QM3SU8VhZmMZTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746594038; c=relaxed/simple;
	bh=EZaPt7slz8Bt3ZiNqrOwboKLy+cCycCnigM78QQx1fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vGMvdlcVUmLw+h8CtSlkuwJ7ffLob4P67bXokmY7yVwnbvWG0SIC5erR1acuFDlVRFOjADzq9BJxDgNIY2rf2phsOnuhyuIbq7VB2ggZu2qHCq+TUfxqnNIwuOiT0oPRW3gc18/QEmTHP3Rn0duQ6cnm0c0xLWrvFAlIJegvt6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g3SriADu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g3SriADu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E033C4CEE7;
	Wed,  7 May 2025 05:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746594037;
	bh=EZaPt7slz8Bt3ZiNqrOwboKLy+cCycCnigM78QQx1fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g3SriADuJm/h4di3tKuU7Q2/MNIut3Cuj1XvkLUTh0XTRjSzpPA43n9I3sQrWkHdO
	 B5ukLUrsFtO+ESMQCvhZ4/WGCTq1DDrw91Xk4BFsnHHwRkayg0xuklUq+BYqI2zZ7O
	 yvUqPCiK+kulvNxfrRsfqf6XMZr8ImYliTAsI2l4=
Date: Wed, 7 May 2025 07:00:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Kees Cook <kees@kernel.org>, Alejandro Colomar <alx@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] EISA: Move devlist.h out of obj to always
Message-ID: <2025050716-unframed-unstuffed-842e@gregkh>
References: <20250423023743.work.350-kees@kernel.org>
 <1f7c8220-09e8-42ae-a611-9a21779badaf@infradead.org>
 <98d34958-e57e-40df-9196-920d40fd57f9@infradead.org>
 <202505061150.4B9A78AC13@keescook>
 <9b50a71c-4106-438b-b475-592a60307a68@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b50a71c-4106-438b-b475-592a60307a68@infradead.org>

On Tue, May 06, 2025 at 12:17:27PM -0700, Randy Dunlap wrote:
> 
> 
> On 5/6/25 11:51 AM, Kees Cook wrote:
> > On Tue, May 06, 2025 at 08:54:29AM -0700, Randy Dunlap wrote:
> >> Hi Kees,
> >>
> >> On 4/22/25 8:50 PM, Randy Dunlap wrote:
> >>>
> >>>
> >>> On 4/22/25 7:37 PM, Kees Cook wrote:
> >>>> I put devlist.h into the wrong Makefile macro ("obj") to get it included
> >>>> in "targets". Put it into "always" so nothing tries to link against it.
> >>>> Solves CONFIG_EISA=y i386 build failure:
> >>>>
> >>>> ld: vmlinux.a: member drivers/eisa/devlist.h in archive is not an object
> >>>>
> >>>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> >>>> Closes: https://lore.kernel.org/all/4a8ba1d0-d2d9-41f8-abf1-d45ec8996d10@infradead.org
> >>>> Fixes: dd09eb0e2cc4 ("EISA: Increase length of device names")
> >>>> Signed-off-by: Kees Cook <kees@kernel.org>
> >>>
> >>> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> >>> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> >>>
> >>> Thanks.
> >>>
> >>
> >> Please merge this patch. The build failure is killing lots of i386 builds.
> >> Thanks.
> > 
> > AFAIK, this needs to go via Greg's tree, but I can see if I can send it
> > to Linus directly.
> > 
> > -Kees
> 
> Greg told me that it belongs to one of your trees, but Greg did
> merge the previous eisa/Makefile patch.

Ah, I thought that was in Kees's tree, sorry about that.  I'll take this
then, my fault.

greg k-h

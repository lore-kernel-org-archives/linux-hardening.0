Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCC119D8B2;
	Wed, 29 Jan 2025 08:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738137920; cv=none; b=QMkx9sLELzd6zcPGGV6q6qB5QL7tLm18s5uGLB/5HYVWaEG9ZF7p/aTb4jftS2KHyYdk9JfTxE+bl6PS//YR2sHUwVRljYDqM3EdCFpLYA5IAcSVOIwAysA0pEVcYx/7MMUy3sNlVb/3hlcYq9hAnddBm+KC7u3Gjrnvi+gUNqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738137920; c=relaxed/simple;
	bh=tYiSc2/ezAKmnXoDnhSE2So/chltAa3Bd4p7brULRzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AxpQOqbgBn3MLRataKFINKhtZPl+/MFi7N16//lg9iRpsqRhiqB5ZmjRDRQuctI4RKZZwgtB8Mm/wm1AV8o6yl9bLUoax/ly6+OHcGMCYRMHTYrk8Dm7tqKFC2yp9kjg18ywGjTNWVe0AOaDqKI0Ph4d4/sLl5N35tP1xnALYrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AUBLl0pK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AUBLl0pK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAB1C4CED3;
	Wed, 29 Jan 2025 08:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738137919;
	bh=tYiSc2/ezAKmnXoDnhSE2So/chltAa3Bd4p7brULRzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AUBLl0pK/oBFWnAyxcm4Ju0XtNaH8nJM9C/2OdsHL0xy+M9H1zp03SFS1w+K+Khti
	 pXi7CYzVGvTCfOdR6Jt0lFzne2VUKtGgd/taZF0vDMWe+owYYvZJ6P7vTHjanvDz+c
	 j6sKC/DGsY5irYnTKQHvCFPidXovqqhgO9P5sOw8=
Date: Wed, 29 Jan 2025 09:04:04 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] container_of: add container_first() macro
Message-ID: <2025012947-hexagon-almighty-57b3@gregkh>
References: <Z5m76U5zh34WbeQY@kspp>
 <2025012955-hypnotic-patronize-8931@gregkh>
 <2295987a-7794-4404-834e-9218349a6f45@stanley.mountain>
 <420cb4b0-16d0-480a-9bd2-7728ee6905e9@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420cb4b0-16d0-480a-9bd2-7728ee6905e9@stanley.mountain>

On Wed, Jan 29, 2025 at 10:33:56AM +0300, Dan Carpenter wrote:
> On Wed, Jan 29, 2025 at 10:29:24AM +0300, Dan Carpenter wrote:
> > drivers/iommu/iommufd/iommufd_private.h
> >    243  static inline struct iommufd_ioas *iommufd_get_ioas(struct iommufd_ctx *ictx,
> >    244                                                      u32 id)
> >    245  {
> >    246          return container_of(iommufd_get_object(ictx, id,
> >    247                                                 IOMMUFD_OBJ_IOAS),
> >    248                              struct iommufd_ioas, obj);
> >    249  }
> > 
> > It's just a cast like you say, but it looks like pointer math.  It would
> > be more readable as container_of_first().
> 
> I left out the important bit...  iommufd_get_object() returns error pointers.
> It doesn't make sense to pass error pointers to container_of() unless the
> offset is zero.

Ick, agreed.  you should never be checking the return value of
container_of().  Shouldn't we somehow check for that?  Is there the
inverse of __must_check where we "just" want to use the value but never
compare it to anything?

> Smatch could check that the offset is zero, but Coccinelle can't.  There are
> a bunch of advantages to Coccinelle at times so this will improve the
> readability and make it easier for static checkers as well.

But I don't see how container_first() will do anything to help the above
type of code.  Gustavo, have any examples of what you need this for?

thanks,

greg k-h

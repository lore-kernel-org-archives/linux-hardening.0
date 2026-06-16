Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C6D37EFEB;
	Tue, 16 Jun 2026 22:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781648300; cv=none; b=EkOrdn2a390hDEnRQ09uSLDF7ecqujXEDj74ouVvZQOR2ldsJ75J+8uxtk4AsExEKiDtEBQPY8gUK1PLF4ojFYoVoEO1IPfiGNKP3/6KDRoEyddKmWHuGlveEr8XZlCWPoEZM7qJPL+IEp3kuHKxRbftaXhztxf0eKPPVwi+GEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781648300; c=relaxed/simple;
	bh=wVjiMzkkbI489d4vVIoBB/9JB7/TfGghDLCaSTuz7cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUPbqESwSr+RN4iaKnoTmAhCzCkf38SZZurtFJfKVl1d53fgEGx37IyYGqdo84mR5N+Ordrec+6cI1qdpgkt09nJOuB45vjbF+Q9JePIUqCleuSHDogeNZxz3THf1zZCI6t+PtTP+z8NbD79whSjOrQDkRJW6pflSE/8CKzZkNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ood0yXws; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ood0yXws"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D061F000E9;
	Tue, 16 Jun 2026 22:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781648299;
	bh=WZBkFMD0AxrU9+dpV3ILJcjn+b8w9r9wdAfVZUzJrHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ood0yXwsSdG2JiGoa29VuVj/oRIu5nS4h0dAzyRcuuLGV3ZkZvLfKwZqcb4JGW5Yk
	 1AG88uOBEAAHcocWKHlPBDIs/VqlIGFF4rXq8yR8GVOTOGsqHfiYwJR0sszThLbct8
	 50TFhJ3+5Nzgr9rxY2oOSxKD0qudpD9RPMATh9o6Huh72kdTQThbb/kCXJIzGulxE/
	 6GC5ZzaZ1fSRNHWDws048OwlioLdT9zLxhgz5hup7M8/R6Kge6s4KYcffkD0yUwb0G
	 L79fHG9KpGyX2sx+g9tDXfVcGzSqnW7B9SrWcOOcHNzdoj3T1bCzEZU307duKUbS2H
	 4RdzUwtxZBCRg==
Date: Wed, 17 Jun 2026 00:18:14 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH RESEND] i2c: atr: annotate i2c_atr_adap_desc->aliases
 with __counted_by_ptr
Message-ID: <ajHLkWuGjGcQfb4C@zenone.zhora.eu>
References: <20260611215501.464405-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611215501.464405-3-thorsten.blum@linux.dev>

Hi Thorsten,

On Thu, Jun 11, 2026 at 11:55:02PM +0200, Thorsten Blum wrote:
> Add the __counted_by_ptr() compiler attribute to ->aliases to improve
> bounds checking via CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE.
> 
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

merged in i2c/i2c-host.

Thanks,
Andi

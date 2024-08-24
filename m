Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0FA8BEC
	for <linux-hardening@vger.kernel.org>; Sat, 24 Aug 2024 09:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724491087; cv=none; b=V+ImWP8apoWF96k80qFHJ0aw2UIeOwoDc6RHtS2M/6NDk3AGpUS3APTArohaDMraCPK+VMSuYxfkitSHpF7dfqJF8rfWpv24HCiDkvl+gGgWaRFjTtHs9bRnaiDhAHWR822jJtSPFJkoovM14tUk21ixutIc3TZ4cHxMjgeocCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724491087; c=relaxed/simple;
	bh=fsiNaL1R0jPYwFZdj68DRBv/9Dc12y6RAM6CHWyUUA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7GhnWMOvuKDCpr7ix9Fct77UdzmYAepvorq7wtGk/Pdb46xoYhVKvFQaONEzSL3Od/ddIgzB2Kr0NBB/YeNpP9KbI/aDbwGx3G+Ag/5aAwAtX4pudAanHHfpCtLmMvC7i+juJSAajsDvt7tPOZ76giH/bFKQMDtVaNYQ76lTJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jr11bAG+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jr11bAG+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123B7C32781;
	Sat, 24 Aug 2024 09:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724491086;
	bh=fsiNaL1R0jPYwFZdj68DRBv/9Dc12y6RAM6CHWyUUA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jr11bAG+Xst8/o0PLVkdEA7nJ7U8qr363jstrrnEO3TiJFB+Z3N09vOI43hRGYaDU
	 qgYxQ9I59EdQ1W7KNxf6gzbGNJSPrXVRq1WDCJ5wUHaxyYSzEQxzM108hvYUdjzYSX
	 EiekuhOZpmLEiN+MCVnneSk/om8CV9snHvm7uJFY=
Date: Sat, 24 Aug 2024 11:18:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: kees@kernel.org, andy@kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH -next v2] lib/string_choices: Add
 str_true_false()/str_false_true() helper
Message-ID: <2024082407-shortlist-ultimate-2102@gregkh>
References: <20240824070950.2014859-1-lihongbo22@huawei.com>
 <dc6453fb-ed20-415c-b591-cbde4ba69af1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc6453fb-ed20-415c-b591-cbde4ba69af1@huawei.com>

On Sat, Aug 24, 2024 at 03:04:52PM +0800, Hongbo Li wrote:
> As discussed in the previous thread, the coccinelle rules and some
> replacements will be added in the future.

Then we have to wait for this one until then.  Remember, we can not take
functions that no one calls, as they will be noticed and someone will
remove them.

Please make a patch series with the function being used, that's the only
way we can actually determine if the addition is correct or not.

thanks,

greg k-h

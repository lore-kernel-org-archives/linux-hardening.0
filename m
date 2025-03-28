Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51287DF58;
	Fri, 28 Mar 2025 15:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743175969; cv=none; b=Y1gxVzoJI7wqNObd73fCaCcTNNh0nN3urj6b43H6/5bONacCgZxl/37eV0Wgz9+Z6hY04lWQ+skE5WfYLGsDs15pAC1b9jpe8eRCn0oS5Hnfy2ebjV19pTp40e6Lhq/EhI4bXufR4e8t+gE6UzooLu1XCOB/WC5gumkd+zNYni8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743175969; c=relaxed/simple;
	bh=nyvXSEqidS12SJhS47TDZr2qHkMFpFzbhcBVfQ56ZAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPdO7uvornajppccf7NtZ76xW0qyjKReKuK0FIitxM+mc+lue8VBrGEn8UB4pmc4yPBUMpcMsCRELeAhov5vHw/RiinUHbkj8JVD0YO9iupcL01x3MG76taoubLWofoLhUP/VwYZsysd3oMkWjFjmRZLyqNXxDgKLuVqkoYLmGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLId2hif; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLId2hif"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087FCC4CEE4;
	Fri, 28 Mar 2025 15:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743175968;
	bh=nyvXSEqidS12SJhS47TDZr2qHkMFpFzbhcBVfQ56ZAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NLId2hif5lVkH94V6V9vUnvvCLmKlIkOmvrtqqMsygWpq54AnfeBmLYJ7Xz2aXCWZ
	 Q5AcFF7WuT6fZZTawrjRhynWrWJu4y9Y8ALv7b0amIRoe+61+vUn1njvDuz41fY+DD
	 IWjmCHgjl9zB5PHou9J6yaUCZa0PQQUp0JnHVsHdbXjqUT3zU29hU0wakT4lQv74NW
	 6riMtv6zDtF7LjRSHWhaTFtT3Eo7/wzd4ucATxaR1T7dRGnlko5Sf6r2/za5zx9eNl
	 mCHQDcTC3IZ9knr/oInFXPPntO5Nn6+JyTuz75BWUMYC7BeGx38uAi5hndyJJcQ4Xy
	 DfqNkTaYmZNnQ==
Date: Fri, 28 Mar 2025 16:32:44 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] drm/nouveau/conn: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <Z-bBHGKTJOs5Ld95@cassiopeiae>
References: <Z-a4meHAy-t58bcE@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-a4meHAy-t58bcE@kspp>

On Fri, Mar 28, 2025 at 08:56:25AM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
> a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> So, with these changes, fix the following warning:
> 
> drivers/gpu/drm/nouveau/nvif/conn.c:34:38: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied to drm-misc-next, thanks!

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B32718FC92;
	Wed,  7 May 2025 03:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746587353; cv=none; b=RHas7gxIQnaL+Hj6zdAc8Lo+QhshOm3rqUIdkWxbWSYN7hZtdlYiJAjPYsX7ilJB7rYgzFezbbZxPNlzFeUGz82eVX6NLWL7V5lrf9N7Fg+8BD7Y8v0BQwjlrb3jG38fcROQD4jTxRfZEFuVp+gkdhBYZ2RYdH8xx/DqALogMfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746587353; c=relaxed/simple;
	bh=VKKg9ZoCZOBSNwA6LB5Lj247+Y6SdSDe5etsTBIdTOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+6nCSeN6bTftudMClA2sDAXQ+xqEBTKxJE4OyZslDcB13GD95m2crzQBZmE6HmExcYdZeEoDuXC9YpNUl6S/PZeQDe0JMw0mYys4HMKWNQ6Gx0MR7R3RyCu+wDT7EubB/9MWkgVaXaodEpy5dGD7xTgVJnwKUX1oUYedBudGlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaQRQo98; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaQRQo98"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD97DC4CEE4;
	Wed,  7 May 2025 03:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746587352;
	bh=VKKg9ZoCZOBSNwA6LB5Lj247+Y6SdSDe5etsTBIdTOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AaQRQo98cW9QcWYxfvI+NkQgpLIltR/ScTcBparMjFuaQJA+h7s8BuBcjnRPZCCS9
	 aUkwHkJXeK5IuzXew5BIty+yhXThaEqteyf7uSMyXGLdHVyNp75jj34FTMT0sLJwDI
	 0AW4JPmzrVwAM8Y/f6vNd3lReQtRG7v2+/VvLZdtk1He7+BqkqFDca+K6d4M1MLd0J
	 dv7Vrg/oDqSulrsjeOGWLK8a//n1x3LMeWSx9IacFCkxzCNFhlZu0GHXqtdBoebCLx
	 mRQMlA1zJY5GjGKTJSIRlqVfyVa/DpvcUTZdSE5dZ6CuIy1wTRZu5Rij9lzA+4eXX0
	 X/LU5jL3oBXVg==
Date: Wed, 7 May 2025 03:09:09 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] platform/chrome: Avoid
 -Wflex-array-member-not-at-end
Message-ID: <aBrO1X0F1ZOz66Ot@google.com>
References: <aBp7mZ8kj9w4CKkl@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBp7mZ8kj9w4CKkl@kspp>

On Tue, May 06, 2025 at 03:14:01PM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Move the conflicting declaration to the end of the structure. Notice
> that `struct cros_ec_command` is a flexible structure --a structure
> that contains a flexible-array member.
> 
> [...]

Applied to

    https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next

[1/1] platform/chrome: Avoid -Wflex-array-member-not-at-end
      commit: 3e552ccf405c0dea6339988202a564357249c437

Thanks!

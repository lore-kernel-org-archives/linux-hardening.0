Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD4A1EBA08;
	Tue,  1 Apr 2025 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743501177; cv=none; b=EaIPvP10RroFM+ZdySvVQk7GnJz3Wt8GhOI2h+Bg2ldTLbyzPAgt162K0/7XH74U7bB8Gsau4Vjzw3QZUhyLL8JEiWmUDRiSDKBqYBoepgVIA3IxdYRZK9wXErJf6SDcMLSEqx8SbAVXGN/saKSZat79sr0YF6zA6e2j/BkUgdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743501177; c=relaxed/simple;
	bh=0y7CwhlwwKJWWd1U2y0IItz2B07DT3mzsvfWUHPPIN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zw1WHUeOUF6M4iX+O6BlodL4IjwGclhlHu58xbIZCCA/AzchwB7+h6yqOMLpojOYedv0Q8gXNL2G2Q+joWWRUrYk6SPxZ6Ja+u7jqhXByvOUyx1MlFsvjiP0Acts3FfmHExv7lmu3W/sv1q55lhHQr/DnqIsXCiudMnCxrBUyG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/vbWlsy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/vbWlsy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66BFAC4CEE5;
	Tue,  1 Apr 2025 09:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743501176;
	bh=0y7CwhlwwKJWWd1U2y0IItz2B07DT3mzsvfWUHPPIN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P/vbWlsy8iOgARZpKKP8Hokv7d2HJ9wv/Lx4ohAkBfpVA6NBYkBCQPn7xgkf6QDfB
	 xWtnP1yBRbSxrwY0m6CPaP1CG6rDX9QOELbFMthGHOlpaI0AQQdBmSTz67gvX6r1ou
	 /juu+YLgQ6fVd82u+/gbGhvtml7IbCWBOLxIjU+vELTAT2L0rjgCpHpbkMlcLaZ6E0
	 KV+f5bFDC4Qg/Asf/idNloTLDnm7n9YxwLMrxmPrf5WhfkcwCngdrji7E2a0gVRN0j
	 +nh8AYZsrBxx+FPskUoXdIu/JWiOIgfUCkESKXL6cjJiBPlYECLMcJOLGVfiF3Dmlj
	 WUKLQFXgVa5Xg==
Date: Tue, 1 Apr 2025 09:52:53 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] platform/chrome: cros_ec_proto: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <Z-u3dW2FRpb3m_JQ@google.com>
References: <Z-adX1BB30dcSJ7x@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-adX1BB30dcSJ7x@kspp>

On Fri, Mar 28, 2025 at 07:00:15AM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
> a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> So, with these changes, fix the following warnings:
> 
> drivers/platform/chrome/cros_ec_proto.c:143:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/platform/chrome/cros_ec_proto.c:761:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

For my reference:
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

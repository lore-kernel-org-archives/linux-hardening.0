Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CE0231827;
	Thu,  4 Sep 2025 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003271; cv=none; b=c7BQxbIH2ESgdUIn4O+/lr6lOEVuPH90nax8baxAJmzNFTvOl3Yulf1WoPFHzFNOUuIHsCuhdCx1xVUBOXfcpg1udYUZDD3J1X99KaH5t04XnYCCNclhKX0oE6xWWO8Qq0eQm1PE9BG/p+Xp1ZhMBFMSE8086RNnlDImZkCHMZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003271; c=relaxed/simple;
	bh=P+wVfpodom1uA9pmTbOEoXVmpJnSH0vCG+IZWf3uVHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/qz9JUAGUQOBAK+lVAcFtkLm4bUWvazICxVQhdjAwV9n08Rh8FRF7PY9CzqFsn4BRlHmon3HChsX1xGWWcKTtbb9VsBGE6OsU7j+zek9Ibcr9Ua4800a9enqaZ9+WjRkgwnJ+afzXbePGOLVM/qVFKQvFJiq40wA7J/CxYlWx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IASTFfbe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IASTFfbe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A5EC4CEF0;
	Thu,  4 Sep 2025 16:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757003270;
	bh=P+wVfpodom1uA9pmTbOEoXVmpJnSH0vCG+IZWf3uVHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IASTFfbeyei4PtKr8lAOptE2IvgxStUhs/N2PDRJTB980jj/baN9bi/M8fg1/gicM
	 KodQ90/N1nwsj3dQIaIVB2Hh9oXwRcXCMi5OnWEQU/IHuq5f+sRBcRZEtNtxvJjCG6
	 XIthoG9yL0QB3fUTOBGldnKRUgdE44VdN32dJm9NQm4XLUsebl3UZYBu5oEilrpZua
	 XDEZvkDwl9fK4uLPH5NdRRJbuAfd7rOpPHnWeXQ/R4sx45dEFrSpV4A+oaam9sEZhC
	 yduDUbfipB1NFPy8vKF/wPtMuzsfjjJW8W6lnTlOrWZ/S2zX+T8OEOL7nFxZGAnzbh
	 jV/J8CAT0rK+Q==
Date: Thu, 4 Sep 2025 09:27:50 -0700
From: Kees Cook <kees@kernel.org>
To: Jani Nikula <jani.nikula@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 3/3] overflow: add range_overflows() and
 range_end_overflows()
Message-ID: <202509040927.30BEE17@keescook>
References: <20250829174601.2163064-1-jani.nikula@intel.com>
 <20250829174601.2163064-3-jani.nikula@intel.com>
 <202509031942.A1669D10F@keescook>
 <eb4a61f86330afe95e232cc515f117ed602e108d@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb4a61f86330afe95e232cc515f117ed602e108d@intel.com>

On Thu, Sep 04, 2025 at 10:34:04AM +0300, Jani Nikula wrote:
> On Wed, 03 Sep 2025, Kees Cook <kees@kernel.org> wrote:
> > On Fri, Aug 29, 2025 at 08:46:01PM +0300, Jani Nikula wrote:
> >> Move the range_overflows() and range_end_overflows() along with the _t
> >> variants over from drm/i915 and drm/buddy to overflow.h.
> >> 
> >> Cc: Kees Cook <kees@kernel.org>
> >> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> >> Cc: linux-hardening@vger.kernel.org
> >> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> >
> > Looks good to me! :)
> >
> > Reviewed-by: Kees Cook <kees@kernel.org>
> 
> Cool, thanks! How do you want to handle merging this?

Since it's touching drm, feel free to take it there. I'm not worried
about conflict resolution in overflow.h.

-- 
Kees Cook

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB738238C29
	for <linux-hardening@vger.kernel.org>; Fri,  9 Jan 2026 19:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767986292; cv=none; b=fMkBMs00yGjTyVhWicqT9UCl/2huI0IETzTIZCGzWlsyQW8420FLxKnrz5War6pE9DgFNxzGfo+bEqSHfW+FWJpARsHv4n2g0TxWfM7tkoumE+C6cfYX1Rwenpqt2X8gPa+LKUpkI1KG9nDvtvtIx8mP/J6PedJNYY/LvDUo0wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767986292; c=relaxed/simple;
	bh=OKvKp1Ti/hPBY0N6wg+4fPIhnPUnu5v/JxpSgb1bhho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=inZ5ck4aAABV5EutdwzXHTt5vnRqDdTKb2UCtzLfDslmI0jmrg0SYSDBH4PtxBc+SfrP5mcsIbUQLCQ2EHW104LrILCl1Kpm3jerlQQtHAqg4hJxCrxqkg/g7N3Gb4sFiP7ODrHu3yRZ3LAtoqbskLVGYJqRpzOdJ0xGJPOZhtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5hKiiSq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5hKiiSq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2AEC4CEF1;
	Fri,  9 Jan 2026 19:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767986292;
	bh=OKvKp1Ti/hPBY0N6wg+4fPIhnPUnu5v/JxpSgb1bhho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N5hKiiSqoVUHbTdytYx847LJ4X5nIdddVL9tEXBrYVoUA8LReVINhGKHggVQQf341
	 yDpm11/qBvJzHtWgLyj0LCH3wug4q0MyFTVOZoeCoGlaKYHPDy6o630PWNWk3ZPLHj
	 8EFKXyANFxtbjT9Yh38sUu4U7ddT370rRWX9rzWk4TcEZkGWWIthSFqtonGF3D1UOQ
	 qUSx/uZajWvZ7h3A09nO2zeZHgFEoUHPWgrvNtbJY0mxtmHjuLc8sMgwlapiIoQMXm
	 3oDPLAhVw1lZwzbhBDGSdYpBbEdXciiZf62SuvPzeRx+WuCYrb/hy2j4M9VWTQgI3B
	 UnDqd7nT7oEUQ==
Date: Fri, 9 Jan 2026 11:18:12 -0800
From: Kees Cook <kees@kernel.org>
To: Yicong Hui <yiconghui@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
	simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drm/amdgpu: Replace deprecated strcpy() in
 amdgpu_virt_write_vf2pf_data
Message-ID: <202601091117.122A9268@keescook>
References: <20260109162514.308143-1-yiconghui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109162514.308143-1-yiconghui@gmail.com>

On Fri, Jan 09, 2026 at 04:25:14PM +0000, Yicong Hui wrote:
> strcpy() is deprecated as it does not do any bounds checking (as
> specified in Documentation/process/deprecated.rst).
> 
> There is a risk of buffer overflow in the case that the value for
> THIS_MODULE->version exceeds the 64 characters. This is unlikely, but
> replacing the deprecated function will pre-emptively remove this risk
> entirely.
> 
> Replace both instances of strcpy() with the safer strscpy() function.

This looks correct to me -- dest and src are both fixed-size, so strscpy
happily checks everything at compile time. :)

Reviewed-by: Kees Cook <kees@kernel.org>

-Kees

-- 
Kees Cook

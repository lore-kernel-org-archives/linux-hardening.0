Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D091A5B84;
	Tue, 13 Jan 2026 20:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768334590; cv=none; b=bszjXTgEYRKfuHvfa4/K3YmBK5VeKiQvuvYYqwq+QyQcwIh5l23+J3/Os4QZlBkFBJPXphftuDRgh4kqnamNKoGE2EaW95Dtah4V/oNxge50thxlYH2Zsu2kSnEWJGkejiiCe0LTDPUoHbm+jf6lZSR+gSPJRZ9Kjp4ix03L9MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768334590; c=relaxed/simple;
	bh=oDzZRixcgoRR5UIcGiyUsMqSH3zU+CsgX/g3pxz0WhA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FrGtu8lDVpImhX3KBska0fxWrEaXlDCEwqoZDikWLtjx7uWBAMTA9LV6hCIOuwfm8ZwUSzwBmKQ0gSHe3xAr1qET9EbsEYaOs8o8VCFF/RTHdjXvVtPD108kd3HMF+Nunnuek1WDz0AiKJO0yZCs2wj2j65i92LIiB3YDtimQyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2vOVr8r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2vOVr8r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DD9C116C6;
	Tue, 13 Jan 2026 20:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768334590;
	bh=oDzZRixcgoRR5UIcGiyUsMqSH3zU+CsgX/g3pxz0WhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S2vOVr8rvUNW0ouDzNFcdSEgFOAWZEBuAihj0BHSDQOnFJAqlFAZ6JjKbXOcOaxqW
	 FqtPAMdQxgAiZxSJT9Oj4QQugGFX7d/6xM63y++xTEwI6x1g21wb3h+JZjoAbdY34q
	 3CvCAj5sIDp9cVSbxd3Bvpq9byC9DKuRaAxGnZdvt8YyPabpREl3px+P77RX8aAmCB
	 Z17IqP2/2O2YFKpU1Dc4tW+eJkX0SSyGJeEJmRDLnGT+jcaoWb83b8SqrbcUR+c0tN
	 vdT1QzkOwHWiQT1ZSUphCTk0zGW9mEcbtu9Bhm1mLA13m5M510a8Mh8MTjo9eFAgfd
	 HUstiW28PjMLA==
From: Kees Cook <kees@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david.laight.linux@gmail.com
Cc: Kees Cook <kees@kernel.org>
Subject: Re: [PATCH 1/1] Fortify: Use C arithmetic not FIELD_xxx() in FORTIFY_REASON defines
Date: Tue, 13 Jan 2026 12:03:07 -0800
Message-Id: <176833458660.2173122.12494481595218803859.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251214125857.3308-1-david.laight.linux@gmail.com>
References: <20251214125857.3308-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 14 Dec 2025 12:58:57 +0000, david.laight.linux@gmail.com wrote:
> FIELD_GET() and FIELD_PREP() are mainly useful for hardware register
> accesses, but here they are being used for some very simple oprations.
> 
> This wouldn't matter much, but they contain a lot of compile-time
> checks (that really aren't needed here) that bloat the expansion
> of FIELD_GET(GENMASK(7, 1), func) to over 18KB.
> Even with the 'bloat reduced' FIELD_GET/PREP they are still hundreds of
> characters.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] Fortify: Use C arithmetic not FIELD_xxx() in FORTIFY_REASON defines
      https://git.kernel.org/kees/c/a71a95ac693c

Take care,

-- 
Kees Cook


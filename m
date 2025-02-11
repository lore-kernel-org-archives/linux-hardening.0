Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E13155336;
	Tue, 11 Feb 2025 00:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739234763; cv=none; b=t8Dp+sTYOJXdXX9GzR1VPueMBNPHTHFsT1BRlVKBXRGf0UqvRqslHCmyVp6u6YyqWxHZFKPV2H9o6JuwsjJEZtgj27BIsIn6llDUCOymqHM+k9+JvviJhhM34AKtJS0dDY0XCfMFao7YojnTxtl2IQVfl7ZkvdyMh30zILDHgrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739234763; c=relaxed/simple;
	bh=tPGo4priezdCeb6GnFIDIaSsVz5e9sArb6Vi3STtr2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Us4AVrf3s72D1WF9tZZcwJbriKMDy71b6BSFxczbwTPmRsujAjEH4HrWWWA9m2X3DOOoJB/NIidd2U/OKQs/4EUf+hpWIKpeyNIlC9Aw5AdP6vwCbo5pfzqIubcCuVymAEqUE7vAV6BMeRffgO9URjIQLRgCdBZkq4WVS2OW9/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8S6fvdO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8S6fvdO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79218C4CED1;
	Tue, 11 Feb 2025 00:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739234762;
	bh=tPGo4priezdCeb6GnFIDIaSsVz5e9sArb6Vi3STtr2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s8S6fvdON2GxXFdej2/oQGihbFLaBFeaM2X485G/NiIGl8CgCHwTO6u8Uq1kbl0J8
	 3dqXS1WNI5ms06DMJtvAOIHHoIP570RYchIe1bi+OclDbXZZFisxJ17MY6qwKntZgf
	 U+zsV5PdgbeqAaIJ7RUgIxGvARn4MiJ3aTTs2xjt99QeR31znwQUJRCnWtqndpvPkV
	 O3r8AyZXnbKdx9hjcsr9JnzU3WsCZ9zTuDV8T0w8b3ESDmsMf8HZBIJaYmqVSCmQvM
	 KLw0Kr1On2vH5GpXiOHwj8ejED4QHTnX3F/ySzxjKXrrYMBqPXlSrT3l9/qk4wwBVs
	 5Ne9qV9oEmHTQ==
From: Kees Cook <kees@kernel.org>
To: Mel Gorman <mgorman@techsingularity.net>
Cc: Kees Cook <kees@kernel.org>,
	Daniel Micay <danielmicay@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Allow default HARDENED_USERCOPY to be set at compile time
Date: Mon, 10 Feb 2025 16:45:59 -0800
Message-Id: <173923475672.2905577.13125502233455074809.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250123221115.19722-1-mgorman@techsingularity.net>
References: <20250123221115.19722-1-mgorman@techsingularity.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 23 Jan 2025 22:11:11 +0000, Mel Gorman wrote:
> Changelog since v2
> o Default on
> o Logic correction and simplification
> 
> Changelog since v1
> o Menu section rename
> o Make static branch usage similar to init_on_alloc
> o Change ordering of menu options
> 
> [...]

Applied to for-next/hardening, thanks!

[1/4] mm: security: Move hardened usercopy under 'Kernel hardening options'
      https://git.kernel.org/kees/c/8907c768bc27
[2/4] mm: security: Allow default HARDENED_USERCOPY to be set at compile time
      https://git.kernel.org/kees/c/caba7c35e832
[3/4] mm: security: Check early if HARDENED_USERCOPY is enabled
      https://git.kernel.org/kees/c/3d2220040476
[4/4] fortify: Move FORTIFY_SOURCE under 'Kernel hardening options'
      https://git.kernel.org/kees/c/b6518de35d6f

Take care,

-- 
Kees Cook


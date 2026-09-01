Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ED447A88F;
	Tue,  1 Sep 2026 23:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788304401; cv=none; b=Tn1ujQdsKFF2UE1nA6FZRRi0beI/H/drsmGmKBYhC74TKKVq4IXS4F2uvnEhFYCKmi7DwykxZBzTtXyIMAaz9JwHoWyQkdWWkrLvQ+KwwrY0mVFc7WANPqzDNmK/JgKqpTFmTH2QRmqQYkX+tYnwOiM3xLK/xHpKtFBcRuUYqu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788304401; c=relaxed/simple;
	bh=77F/xb91mtPvbazAUFTBZpgswH+DCh41EhPVg9t/nGw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YMmdKkNoLhyUpbC3MliO3Mw2lguRwPhqBhDIObl0DVk54QIbCWczCBocb16y0wM0Q7+WgfkSfZ8ToHz97d/VxFHd1VOreSU+nFZmGWUEDmeKG4zF6Gg9qvKG88NYvQ8avprJlxo+6qf8yS6PraUuq3z9cGayeY+hfeVDmfHaxmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myfiKrGj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myfiKrGj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F571F000E9;
	Tue,  1 Sep 2026 23:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788304399;
	bh=VvfbNwt9clnuEqeZDUHIGsWqWppc8V1nLCVpEWh7upg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=myfiKrGjjpQjTnTgmKMnzbwTsI5FE/YXdw8FyPNkpJeIE5Xg4wjptXNf5Sv4fXe/V
	 O5k5giU1Qkb80zoOBWxJr23n6jt8+pFaoi6a8uChm+m4ujZKx8akfbAOSuPOGbyoRc
	 4lT2QCIYT6sWjeR6Mc1lppSUJAD6SgL/o5q5hZunfP2MjUJczU5MATnzhfQ+wccYEN
	 Gdog2Nwt2P+Bla3H253o7OzN4oTvZ+Nj4jMyjCndNv0UyGZ1X+WVvbgWSwtJFVr1GA
	 QGZ9TjcZuzq5d/EkSReq2hFKjknF46TL7DWURdaAvUMEKy+IV1OvuH5Qq5arXNoPJp
	 uwJVt1JOBZtNw==
From: Nathan Chancellor <nathan@kernel.org>
To: kees@kernel.org, Jaihind Yadav <jaihindy@qti.qualcomm.com>
Cc: nsc@kernel.org, linux-hardening@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-modules@vger.kernel.org
In-Reply-To: <20260820060116.786173-1-jaihindy@qti.qualcomm.com>
References: <20260820060116.786173-1-jaihindy@qti.qualcomm.com>
Subject: Re: [PATCH v3] scripts/gcc-plugins: suppress recorded GCC switches
 for extmod builds
Message-Id: <178830439251.3086667.14013595113820949472.b4-ty@b4>
Date: Tue, 01 Sep 2026 16:13:12 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=764; i=nathan@kernel.org;
 h=from:subject:message-id; bh=77F/xb91mtPvbazAUFTBZpgswH+DCh41EhPVg9t/nGw=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFnTY7hfxj21CX/TPuWLs3GSTG32VKYP3sUNuXu5p+920
 y2aXJrcUcrCIMbFICumyFL9WPW4oeGcs4w3Tk2CmcPKBDKEgYtTACay+Q7D/zCOXS8YdESEC7ev
 UkrZtDIpplEy+hDnEr7Qg8VO25O7fzL8lQ7YpVbwL8Zfewln1VMDk9ua8k3xS1ovtq23bPw+d1o
 7JwA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

On Thu, 20 Aug 2026 11:31:16 +0530, Jaihind Yadav wrote:
> scripts/gcc-plugins: suppress recorded GCC switches for extmod builds

Applied to

  https://git.kernel.org/pub/scm/linux/kernel/git/kbuild/linux.git kbuild-next-unstable

Thanks!

[1/1] scripts/gcc-plugins: suppress recorded GCC switches for extmod builds
      https://git.kernel.org/kbuild/c/51794b107d54b

Please look out for regression or issue reports or other follow up
comments, as they may result in the patch/series getting dropped or
reverted. Patches applied to an "unstable" branch are accepted pending
wider testing in -next and any post-commit review; they will generally
be moved to the main branch in a week if no issues are found.

Best regards,
-- 
Cheers,
Nathan



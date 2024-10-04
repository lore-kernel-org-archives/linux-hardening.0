Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155E11E378C;
	Fri,  4 Oct 2024 17:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728064585; cv=none; b=uDM6zhVe0D6UstaUCYU99dDo0TaIuk9CZESPfF3BvGCQXjwOcPB5lJRt1Dvqn8AzIipDH5YktbsHlOyLUBd34BDrqt7+chDbOgVPRRsdRUq9yTZHCkQ5ZLUq6L+fIHL/M8erJsFiKkbegfnRx8dfLzO/Vh++Hkyh8TwKyxqsSpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728064585; c=relaxed/simple;
	bh=vxJsSscfbkhGfqh/a1LftC8GagvzaxuC7AKK0WsARrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNnEGjEoJYvWwLFB4XHTXBbcp/9DA4j2mdUSLep3aY7uqYoJKCLtEq3WlxzQKDKGdVq3SmbFn88+tj5q9YWJaSAnIGm3El7xcZ8DePPpYoGQBY+BSCekWtkYIdp2zkZkUipgxL5ajqYs+HedcglPnqJRvZpcC+t+7jHWxBM4ViE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QN2j9Nzw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QN2j9Nzw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D5BC4CEC6;
	Fri,  4 Oct 2024 17:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728064584;
	bh=vxJsSscfbkhGfqh/a1LftC8GagvzaxuC7AKK0WsARrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QN2j9NzwihP8e5kTgemkYpDRjSqBnRuTGr/yTnNdce7nYr6rQBjAS76uHE5d3nWUE
	 JdKCWQ4cTTC3RQcrItXG2MdWY7lQzGfzMy/R2pM/Ln/hcaiyJrjlC08MhYva9MgWfp
	 x/+qQn8zOLw4LknyYJSYNIQZx6gQxbHpv+INnqBb+ft34oL8nfPbBfjtFxl6B2wGKd
	 6bYzxvljhKYLoPnGfketL+CK/3thYsBJqZu2PPCUUxx+HMLllNKIrfpYCEhlC7IS0f
	 oCkOJ/n2HKQD20ptXkVUv8R9N5CETcuRZW5NvE8gDS1ZJfzuFCEKuzEIDT+XE9eYXB
	 Uz8JaWYhrwaeg==
Date: Fri, 4 Oct 2024 10:56:21 -0700
From: Kees Cook <kees@kernel.org>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Jason Montleon <jmontleo@redhat.com>, linux-hardening@vger.kernel.org,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	linux-riscv@lists.infradead.org
Subject: Re: [REGRESSION][BISECTED] Cannot boot Lichee Pi 4A with
 FORTIFY_SOURCE enabled
Message-ID: <202410041050.42575499F@keescook>
References: <202409221511.9AF49BD@keescook>
 <CAJD_bP+6qCgseo9of-cKW3+nH_UbGFwPo6WRbqqcneOZ+EEtOw@mail.gmail.com>
 <800CC050-E858-409C-A565-A6EF430E1B25@kernel.org>
 <CAJD_bPKNbKo5tj4OV4MpgtSN6_FXfmQtBFgVFzZeZapCPNT6PA@mail.gmail.com>
 <eb7354f6-98bd-45c6-a616-733637848a14@ghiti.fr>
 <CAJD_bPKHA5+Ta1vzokN-TXJU4bk4OA5QTXEEvAwmzLzmW8YtTQ@mail.gmail.com>
 <f9d17698-0c74-42b7-acc8-3ca3adf3ba4d@ghiti.fr>
 <CAJD_bP+ZYKFaeZ2hQXjAZda=RhLkfnXfGLW-ZYTrOV4GfNRzpA@mail.gmail.com>
 <202410031417.A5AB8BA5@keescook>
 <0c9371f2-e8e9-479f-856d-408a81213747@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c9371f2-e8e9-479f-856d-408a81213747@ghiti.fr>

On Fri, Oct 04, 2024 at 01:37:44PM +0200, Alexandre Ghiti wrote:
> I have a question though: should we do something about the following
> warnings? Is there something wrong somewhere?
> 
> Wanted to write 8 to a 0-sized destination: oldptr at arch/riscv/errata/thead/errata.c:185
> Wanted to write 28 to a 0-sized destination: oldptr at arch/riscv/errata/thead/errata.c:185

I think it's a problem for fortify, not for the errata code. I'm
still looking into it -- they are unexpected warnings given the types
involved. I haven't been able to reproduce it in a stand-alone context
yet.

-- 
Kees Cook

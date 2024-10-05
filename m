Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A445413C3D3;
	Sat,  5 Oct 2024 16:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728144255; cv=none; b=nMIgYhP9fzM5KkgtenZTCLNa1Ym8+NDCpbbgMsQrAQ2uFssMMdVgfkbS78smBYfYDXSc6o3U8TvcVsih98apnhuSlLqTuhPAzcleGX+dV6eCTiwJPFoF+WrY63i/tDXWKpN0gI9CMxrBV+YnmGjjUHcM/ZxQlxNReeaLPSmeb5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728144255; c=relaxed/simple;
	bh=3kAl7AjYTqaiWlIoDOVi3hSGnrwStWTjPrjLj2tI724=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=DstL5PqIBwzBTVcbQrS9hmIbKXAU/dwYG/syJA2FmIk0KHX+IhOycSBdJrAFXxLKllsISi0vWUrqv4DHrlKFYTA5UpVfeNzL0Uny/jyRRBqspz5iZ1RSA6G4VumQLd1jUKRdKjhvl9y5JctYPLNISUrXTpQIpxwXBFnnoJmN1fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLMvt9Sr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLMvt9Sr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE239C4CEC2;
	Sat,  5 Oct 2024 16:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728144255;
	bh=3kAl7AjYTqaiWlIoDOVi3hSGnrwStWTjPrjLj2tI724=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=eLMvt9SrhuO+7e/pS/H9lQjX2AqV059uevEzfrx+Dw+iuWn+LOJbwklOMYNL+a3QD
	 zoDlXuPx9dWYCDbmMdEZ6GPvMZPl2UeOwym082tTGhnmbwlsTT4RTHXdxXiJl/yDrl
	 f8SU9tvLHwjnmJ+FcMDjgiKzomkn3GDpjCLnzhURhh5c9X/ZYJz/A1tknReLKn6QNR
	 xsV49DEm6eWuiOjUE1qbpPapztLqHTtfvXkpWiWpQSxy3NqZB0BMFbSMNhDE2445CZ
	 e0Lp477VZJ8v1xun5OhT0MF7asrTfTf0v2JrxyHLA3m4y/IPvwaOWaka3vE9gqeC4J
	 BvqcMf7nPW56Q==
Date: Sat, 05 Oct 2024 09:04:11 -0700
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Danilo Krummrich <dakr@kernel.org>
CC: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D=5Bnext=5D_drm/nouveau=3A_Avoid_?=
 =?US-ASCII?Q?-Wflex-array-member-not-at-end_warning?=
User-Agent: K-9 Mail for Android
In-Reply-To: <45560975-7215-4205-8d3b-a01009c9b4f5@embeddedor.com>
References: <ZsZLFS1CsHkKjw+C@elsanto> <ef5a8e6d-cb97-4872-901c-cf4bbec23be6@embeddedor.com> <30530165-0ea9-4f02-9d8c-e8abc9eda5a7@kernel.org> <035ae74b-5df5-493f-9835-02c1c30ccfcc@kernel.org> <45560975-7215-4205-8d3b-a01009c9b4f5@embeddedor.com>
Message-ID: <81E112F0-51CA-4171-8DA7-59EC8AE14510@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable




>On 03/10/24 12:36, Danilo Krummrich wrote:
>> On 9/13/24 12:23 PM, Danilo Krummrich wrote:

I am reminded that I should check all my MUAs to render the date as YYYY-M=
M-DD so my brain doesn't explode when I see people "time traveling"=2E ;)

(BTW, what MUAs do you both use? I use Mutt and K-9 Mail, and I need to ch=
eck the quote prefix settings in both=2E=2E=2E)

-Kees

--=20
Kees Cook

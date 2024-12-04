Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F95F1632FE
	for <linux-hardening@vger.kernel.org>; Wed,  4 Dec 2024 04:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733287444; cv=none; b=titvAaWV+KmCPIIk4cPB94nOJIwV0p80CiuJF/SUn5jrGeoGfhV6R7F59RM1Yyfr8ebwXV7V2b6UoX+qvpCzjIOjehnGv8UZUCGSfqSGY8CRSWFb1jBFZJXIOoXSmPv56E88eitEf5wxt/Rwsj4Fj2W2fNPF1jQIRo0kxoswFmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733287444; c=relaxed/simple;
	bh=DADtP/o6ub5Tni479teS6nYXfJ4myk1oHlPJmOJPrWI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=O6vp7v1LsgZ27wjv237wVE7TzVeN8ukA22cwuDK4bXGyy2L8LB2xk7g6Ko3GVI9zAO9b/6I7NkNiPeIvm9bq6DmxtwHew1+RN1BF1NFjRn0+4d3TGGnQmt9lg4BNKXgN77tf8KstxqA9Wcp6eIs7OQ4jDlI9uP2bu0HlcSlBziM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rpcqoDlK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpcqoDlK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB64C4CED1;
	Wed,  4 Dec 2024 04:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733287443;
	bh=DADtP/o6ub5Tni479teS6nYXfJ4myk1oHlPJmOJPrWI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=rpcqoDlKTU1jsbrQNie44i4xKe6rjvUvREyH7QEom9u5llG1YAo4JQg3XggqsD7Mx
	 U8omtI5x7whVocUqSygiRoV8Wk3oVscaYZ/AGDPhOymsQRArRJVX8Nh0p3/cLW82oP
	 wCVF38QB159d0GPbST+mgglRfeBRMOUiYvALfm6Gn5Zvo6ePzy8PmYyo8s5061GvFo
	 wsWzn9Vvsg+MFKf9ONxnpiUlV31qr6sDj4yueynHEEg1twOaG3I65JsnRncLVI7hdf
	 +R0rP8i588nEN/4pQ0jtqIl/09ps0K1GK81+XTsVioX1Hsx4U8yr/ZW8yJLfQ+YLzq
	 5RKS47HfVQyqg==
Date: Wed, 04 Dec 2024 14:43:54 +1000
From: Kees Cook <kees@kernel.org>
To: Matthew Wilcox <willy@infradead.org>, Uladzislau Rezki <urezki@gmail.com>
CC: Kefeng Wang <wangkefeng.wang@huawei.com>, zuoze <zuoze1@huawei.com>,
 gustavoars@kernel.org, akpm@linux-foundation.org,
 linux-hardening@vger.kernel.org, linux-mm@kvack.org, keescook@chromium.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_-next=5D_mm=3A_usercopy=3A_add_a_debu?=
 =?US-ASCII?Q?gfs_interface_to_bypass_the_vmalloc_check=2E?=
User-Agent: K-9 Mail for Android
In-Reply-To: <Z09icnP7QuaLg4Qv@casper.infradead.org>
References: <57f9eca2-effc-3a9f-932b-fd37ae6d0f87@huawei.com> <Z077_8rNvTGrCb8L@pc636> <92768fc4-4fe0-f74a-d61c-dde0eb64e2c0@huawei.com> <dd3f0a9f-ec3c-46c3-8231-2022b67094a6@huawei.com> <Z08KAupLBo--JGz8@pc636> <76995749-1c2e-4f78-9aac-a4bff4b8097f@huawei.com> <Z08M88NdLfugqhu9@pc636> <d659d925-a322-4566-955a-97894a2aa795@huawei.com> <Z08TlFqWVWs47g9z@pc636> <Z09VwuhfQbbro-gA@pc638.lan> <Z09icnP7QuaLg4Qv@casper.infradead.org>
Message-ID: <D99B0795-152B-4D63-94C4-5953192A5E53@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On December 4, 2024 5:56:34 AM GMT+10:00, Matthew Wilcox <willy@infradead=
=2Eorg> wrote:
>On Tue, Dec 03, 2024 at 08:02:26PM +0100, Uladzislau Rezki wrote:
>
>I think there are a few other things we can try here=2E
>
>First, if the copy is small (and I still don't have an answer to that
>=2E=2E=2E), we can skip the vmalloc lookup if the copy doesn't cross a pa=
ge
>boundary=2E

Yeah, this seems a reasonable optimization=2E

>Anyway, NACK to the original patch; that's just a horrible idea=2E

Right, please no debugfs knob=2E The point is to make sure the check canno=
t be disabled at runtime and to make the check a no-op=2E Please use the bo=
ot param to disable this check=2E=20

-Kees

--=20
Kees Cook

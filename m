Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D560933122C
	for <linux-hardening@vger.kernel.org>; Thu,  4 Dec 2025 20:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764881879; cv=none; b=OAHXDusYIYSw49T/EiygKujg1DCFr5bdiF/rbSUCrFxdqTCIjqTqDVS2viw4sECloW/fdH34zEgImHRcChsbecCYwZLlsA2uY+ZWjKa95nh8t499z03/euqAKdGJJdozzg/ici6Alu4Ry19LhVnA+M3vlJYXg8DYf8yuIWOvxkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764881879; c=relaxed/simple;
	bh=Z8OLr1JUXWzWsC+mv3c7guIZ53FNOHFBy+7FOWKCHUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ly/8iLbEtqcRfIh9tKbdeaMMVwJ3l1kAL6SAGK+S0GM9xZqfM7b0+UhM5NwT8Ao/blY3VmuIVat8tjYgEvvyfjGzidL58zFq8/nG+yNSTKfh/UhzsGJ3x2DRJ3dW9JUuQA83Nz/EdteZ6gL0pmasD192wj5VF5rAaXpDAcoj2HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=cQrqTp5n; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="cQrqTp5n"
Message-ID: <2294ac5b-6977-4f46-964e-b3a30b88efbd@packett.cool>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1764881865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+LObVJ/Jz5GOWMc2vv7GqK0leAB+Wq1OHsGH8rbfCSs=;
	b=cQrqTp5nuJhGU+m7uZASIgPbervqLwa+iUxKgVQOMcXSgl8os6cC1oAsLaMIidT4d+Yr0t
	n7ZuIz42og3yNzGSI61UTwnNHDnzpJeRXQf/GIMTXZsNjMoqZ1j6cry+SS3Yrp4V9VuGDF
	dsuzCUDoCJY/tlIFqjO8glf6zVYjwiZN1JRq86pGZEdaWeUI34wkv6XENz9d452zNSxjjr
	q8hmw59WpDKvOm2JLyGPNDNEhX1porLM26ch/QRN/0ggZ0/fY8bzZ6XFGeaY3NdHNi//Zo
	GXqRi9uABxUvkFAmRxe4MzkjFiM7fbjdMF2JZAOM3GiUWxvKUvJOxKgU86o/2g==
Date: Thu, 4 Dec 2025 17:57:32 -0300
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] efi: pstore: Support late setup with TEE-backed efivars
 ops
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 Ard Biesheuvel <ardb@kernel.org>, linux-hardening@vger.kernel.org,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251203042850.14210-1-val@packett.cool>
 <CAC_iWjKHO3BGdaK=8a1A3Ps3U5Cqt2urJqL8PPfGcaqsMw1Qgg@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Val Packett <val@packett.cool>
In-Reply-To: <CAC_iWjKHO3BGdaK=8a1A3Ps3U5Cqt2urJqL8PPfGcaqsMw1Qgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 12/4/25 6:49 AM, Ilias Apalodimas wrote:
> Hi Val,
>
> On Wed, 3 Dec 2025 at 06:29, Val Packett <val@packett.cool> wrote:
>> On some platforms, EFI variable services only become available when an
>> appropriate TEE driver is initialized such as qseecom, gsmi or stmm.
>>
>> This would work fine when efi_pstore was built as a module and loaded
>> late by userspace, but with CONFIG_EFI_VARS_PSTORE=y this driver would
>> quit due to non-writable efivars before the necessary driver had any
>> chance to load.
> The problem, at least for OP-TEE/StMM, is that writing the variables
> to an RPMB depends on a userspace application If CONFIG_RPMB is not
> selected. We have no guarantees that the app will still be alive.
> I don't know how gsmi or qseecom deal with writing variables. We can
> probably allow it for StMM if CONFIG_RPMB is enabled, but we'll have
> the right trigger to do so.

qseecom/uefisecapp does not have any userspace requirements and works 
fine with efi_pstore.

I don't think complicating efi_pstore with extra logic about which ops 
are fine would be worth it..

Either way, it currently *already* tries to use whatever ops that have 
been registered if it's loaded late as a module by systemd! The only 
thing this patch changes is the CONFIG_EFI_VARS_PSTORE=y case.


Thanks,
~val


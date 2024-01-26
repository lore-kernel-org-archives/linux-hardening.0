Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6664454BD0
	for <linux-hardening@vger.kernel.org>; Fri, 26 Jan 2024 22:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308594; cv=none; b=G1AG4orijCFEcOXKcz4v+oHUjsyXEJh/9uo9Uk3K0rJZUda27sEmgzHqKjY/0EUFFULOeHBfW7zD9BpD0Gc/IH1B8X/K9ICKf+xsVgFRRpuyRqfkrmAwA9Ik3zgAszKEWvMqkxvWs1PrwEHPCialEYzKLRYa5frsWotK5+N5Lyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308594; c=relaxed/simple;
	bh=TuLldHRMoPdhbvg4tAmasRPjnDmfBZBh2qMiSNy3aIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kOuCQ/BOHc/eFbrPMMwEPEkypK6PhMdCCE7c4qa1r88eT/UmHn9HulNvzDl3nIXETgcwATnlnfQZ171grh/buDJVwnvTJ11IQ8V1qm56hsSWsl6R2pVVFJwSljZSg4YeCErg1it3AoKm9xk0IRYyXgbNqA9MV2khIdohQa3JlCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PpQnaLrF; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PpQnaLrF"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e76626170so14716195e9.2
        for <linux-hardening@vger.kernel.org>; Fri, 26 Jan 2024 14:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706308590; x=1706913390; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3vb86YnCobjeOJ1buOfJZ8O/sRnmqyBtak+zDHciKpI=;
        b=PpQnaLrFhwvHKLjwPrX3w0S0GFitSutYIKMHGe/Xb8n5kUgWcriDKfDrSqnRoAlenP
         R++3lIhpFDBg0KWd1NjPC3wQHlwHNbEllaz1KLctTAiQ6gJ9svUHyX+iZsBspI+JwlcV
         m1/N2pIqc4GuNq8hn9FaaL1QWmvgrjWo37P5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706308590; x=1706913390;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3vb86YnCobjeOJ1buOfJZ8O/sRnmqyBtak+zDHciKpI=;
        b=kPXd+T/U89ou4hedVWrjeKjix1/2+4BTHQyOZvzdU6cZrKJvk7EFpdaykGD6yYlJ9+
         RWyLEHa38pDERoA0Ah0eQ9+QqrmPD2qDGJ+OPYJ3zBwa1B8C9sQ/4yAQIIWQ8r2EZ4Hr
         23r81E9imhhsyb0FPdNsKrLVlpp4WDjbYYV6z26ytoO/eV9goKtsr5FL9r8eoEWSbjEi
         kpnlcROBk6/SVkld2U+aTboc1Tdj9TtIlPeqk0XDSf/bDmDfIEBJwQ0+Mu1iF4RY2I9H
         liVUlAEvfZhwpXw2Iox3pymQWQuP9me8X28EINjVKf0y820u1b/j2tzUl39Av333reYN
         iU5w==
X-Gm-Message-State: AOJu0YwS+cmLFxprNKjfEw72pFkQpoVmZly+ifZYEOYaHudTsus7cZVA
	UEoclO72o/CW+/Ho+Bh9joM3UI5msGGglL1BAs3KykGdxGMP9EHH6CfAmLSEl1c9B9HtIcQWR8A
	SNt7LEg==
X-Google-Smtp-Source: AGHT+IHWkxSKELXVjY5qD9uZXHxBZvRrAiQe13wI0iC6/CNyzJYXxkFT+L7cC/gKMXRZ0ooTHob99A==
X-Received: by 2002:a05:600c:a3a5:b0:40e:59c9:e603 with SMTP id hn37-20020a05600ca3a500b0040e59c9e603mr369160wmb.135.1706308590355;
        Fri, 26 Jan 2024 14:36:30 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id ek22-20020a056402371600b0055ca93f3930sm1048843edb.0.2024.01.26.14.36.29
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 14:36:30 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55a8fb31fc2so744622a12.0
        for <linux-hardening@vger.kernel.org>; Fri, 26 Jan 2024 14:36:29 -0800 (PST)
X-Received: by 2002:a05:6402:180f:b0:55e:825b:724a with SMTP id
 g15-20020a056402180f00b0055e825b724amr263564edy.16.1706308589610; Fri, 26 Jan
 2024 14:36:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Za6JwRpknVIlfhPF@work> <CAHk-=wjG4jdE19-vWWhAX3ByfbNr4DJS-pwiN9oY38WkhMZ57g@mail.gmail.com>
 <4907a7a3-8533-480a-bc3c-488573e18e66@embeddedor.com> <202401261423.7AF702239@keescook>
In-Reply-To: <202401261423.7AF702239@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jan 2024 14:36:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiaaCatzmF6GXxP97pa8oEX7e4rBpd4JgsbKex3Ek1_9A@mail.gmail.com>
Message-ID: <CAHk-=wiaaCatzmF6GXxP97pa8oEX7e4rBpd4JgsbKex3Ek1_9A@mail.gmail.com>
Subject: Re: [GIT PULL] Enable -Wstringop-overflow globally
To: Kees Cook <keescook@chromium.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 14:24, Kees Cook <keescook@chromium.org> wrote:
>
> I think xe has some other weird problems too. This may be related (under
> allocating):
>
> ../drivers/gpu/drm/xe/xe_vm.c: In function 'xe_vma_create':
> ../drivers/gpu/drm/xe/xe_vm.c:806:21: warning: allocation of insufficient size '224' for type 'struct xe_vma' with size '368' [-Walloc-size]
>   806 |                 vma = kzalloc(sizeof(*vma) - sizeof(struct xe_userptr),
>       |                     ^

That code is indeed odd, but there's a comment in the xe_vma definition

        /**
         * @userptr: user pointer state, only allocated for VMAs that are
         * user pointers
         */
        struct xe_userptr userptr;

although I agree that it should probably simply be made a final
variably-sized array instead (and then you make that array size be
0/1).

               Linus

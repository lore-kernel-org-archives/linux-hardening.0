Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154E5389444
	for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 09:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184225; cv=none; b=APbj0YXOBhiUkvM7BPMrHlKTLgWFXQCHwDX06QXAHwf3ADLxJ3ACNPw9ARG4FVAAAClGcdDNeU9nTHwEWRAxZ8y/oCGZ4Ouxte4E0mcw195YvzLwQDpgZDyfIT9r/To/w8RlNA3cDEBdB7qJEmu0Bus+dGxZYscRCNIpLWBid5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184225; c=relaxed/simple;
	bh=VV0WQeCgbPqBTi7yab+uEYQeq6u9LFtTUX4clbsM2Vw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j0VopyYg5N9KZthcHj86MQDmItuFIQR4rRIWhTM437YrO1FAx6R3tMj9guy9G5NuSOSBpUja3iuXSVHwBIKxN9YfStTz7nXPHckh8h2cZ7WhZnHkGW7uYWQDVSXE+rV4SNehs/PoErbSKRBIwehPAeGjvfrDrGKR6JUd9pkOzAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7de4a9cb8eeso3365170a34.0
        for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 02:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779184223; x=1779789023;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+2SZGl9spcuw3ZVraVsNeWL62/l5e6HnqNdDh6fCso=;
        b=Axn0QQBXX61RnQVrbBK/2mOZViBiNK5DaxNZCZCMxm/ZM+7eYaSSVZtJ53CukOHycl
         8oFCxvDjecxfPtQmt6IsSXkGYZNF5SU7+xMPC7hO+RFxASwT5b9hJc+kpIorOyFODBSI
         KECmUpbiEmlFgKFqXsWFq5UnVbX7OrNxt25PfV8c37OP7bLjZoQzaBg1m8j0VVdFOeon
         1lV6fLK3avNkILlRSuiAuslIFy3YU1xelzAUyXm6S13l/h//jtsE9+uQMunyhWU7Kjs3
         XXk8Rtr6CrzF/tA391wsz9X3lc3BS0oddzCwHOvlpR/IPjPbxnMoBzHHfNEcgsI3DfnN
         w6pg==
X-Forwarded-Encrypted: i=1; AFNElJ82kMAcu4WGSzEhIEwxHQ7MxvWZCZTxUsEg6zk/66LDV4hahzb5kodSkAAiOPnQToi1wfLHlwANQbKdEhpGLKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzlWWmAMyDHap+CGXcopgeBrr6aGDIQ6N75SykLXKnszpQzjOH
	50TgYmrG8HcGG8N9kaMlJikSzLUC3YTpQW6gJfZRACG1AUDSOahDJzMJfZvh0NKD
X-Gm-Gg: Acq92OF4Fv4wj/7ii1Msd0ZpUBclCI1hAVxtFskfWHyqH4ZFOi7FkN5+b4YdB3UqcZL
	nIwUiQksPou3vESZ5wpAZ3SlfTarI26/XCqijC344busynqJqC7YHvJuwwL9mzn+JTj8jU/5hIR
	K7bic04hnY/UwcXzbrsa3M6JExqFTtkYOb61NgHE2LWRpP+EdL+V8qixs7teeScTINpYs5aGPL0
	cLR0bPpY02O8KztAfqEi+bxpK+zPO9uh/B8qA357FZ7Pxi8NYNzybeonf9MEMzmHRLpsz0WQxBC
	sbDysGx9zg7Zn8cGuhXy6ATf/gfruRQw2gFN6QsGuW6Rr85BbohdL8S3TbokR5nM+4Kt1nzPvyX
	OGVqeUPPB4MJZHyLotOD8bMqkYMkQU1H/cCfLHPeTb1eeo5lRR5wNae/jyPwWCZ1sO2IzXNzNNI
	zX1M5BlmxVQ9aYDOwOTia6RNkyjHF5VigaEvYu7VT7H8tZcGsxPX3a4jqj8NdwHQHF
X-Received: by 2002:a05:6830:6f8f:b0:7e1:90a:9c81 with SMTP id 46e09a7af769-7e4f2bdab70mr12587074a34.26.1779184222833;
        Tue, 19 May 2026 02:50:22 -0700 (PDT)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com. [209.85.167.181])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55b7cd6c0sm10434447a34.4.2026.05.19.02.50.21
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 02:50:22 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-479fc1fc048so2827096b6e.1
        for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 02:50:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+KzVxTdw0yCfeUYN/TCn8EL80nczD8QpuU+QlycVTKbw5wl66MbHPbS3T7+l8ljVoTWujTtn/o+rQ+FwYamVc=@vger.kernel.org
X-Received: by 2002:a05:6102:511f:b0:634:d42d:15e2 with SMTP id
 ada2fe7eead31-63a403ac9a2mr7077474137.26.1779183821499; Tue, 19 May 2026
 02:43:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518042833.272221-1-enelsonmoore@gmail.com> <20260519094820.1f05ab8e@pumpkin>
In-Reply-To: <20260519094820.1f05ab8e@pumpkin>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 19 May 2026 11:43:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVw349EBZUuYZAns3FnTndx0A=PHbznxarYuAQr8nbqDQ@mail.gmail.com>
X-Gm-Features: AVHnY4Lfn8Mcrjf-CZtgFTL8ilhwbGlXFwz-O3Z8xcIZpla9SRL4d3C994HiNs4
Message-ID: <CAMuHMdVw349EBZUuYZAns3FnTndx0A=PHbznxarYuAQr8nbqDQ@mail.gmail.com>
Subject: Re: [PATCH] nios2: remove the architecture
To: David Laight <david.laight.linux@gmail.com>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>, linux-doc@vger.kernel.org, 
	devicetree@vger.kernel.org, workflows@vger.kernel.org, 
	linux-arch@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org, netdev@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-csky@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
	Hu Haowen <2023002089@link.tyut.edu.cn>, Dinh Nguyen <dinguyen@kernel.org>, 
	Kees Cook <kees@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Dave Penkler <dpenkler@gmail.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi David,

On Tue, 19 May 2026 at 10:55, David Laight <david.laight.linux@gmail.com> wrote:
> The company I used to work for used 4 NIOS II inside an fpga.
> The instruction timing for one is pretty critical, it has some code that
> has to complete in 122 clocks (worst case).
> Our solution was to spend a few man-weeks writing a compatible cpu!
> I think it came out with fewer pipeline stalls (in particular it 'lost'
> the one for a (predicted) taken branch).
> The maximum clock frequency might be lower; but it is ok at 62.5MHz and the
> higher 125MHz in just impossible for all sorts of reasons.
>
> OTOH I really wouldn't run Linux on it!

Sounds similar to what CoreSemi is doing with J2 (nommu, also for
predictable latency), but their products do run Linux.
See the video from the LPC session at
https://lpc.events/event/19/contributions/2097/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
